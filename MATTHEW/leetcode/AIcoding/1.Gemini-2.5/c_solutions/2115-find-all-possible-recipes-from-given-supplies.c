#include <stdlib.h>
#include <string.h>
#include <stdbool.h>

char** g_unique_strings_arr = NULL;
int g_num_unique_strings = 0;

typedef struct {
    int* arr;
    int size;
    int capacity;
} IntVector;

void IntVector_init(IntVector* vec) {
    vec->arr = NULL;
    vec->size = 0;
    vec->capacity = 0;
}

void IntVector_add(IntVector* vec, int val) {
    if (vec->size == vec->capacity) {
        vec->capacity = (vec->capacity == 0) ? 4 : (vec->capacity * 2);
        vec->arr = (int*)realloc(vec->arr, vec->capacity * sizeof(int));
    }
    vec->arr[vec->size++] = val;
}

void IntVector_free(IntVector* vec) {
    if (vec->arr) {
        free(vec->arr);
        vec->arr = NULL;
    }
    vec->size = 0;
    vec->capacity = 0;
}

typedef struct {
    int* arr;
    int front;
    int rear;
    int size; // Current number of elements in the queue
    int capacity;
} Queue;

void Queue_init(Queue* q, int capacity) {
    q->arr = (int*)malloc(capacity * sizeof(int));
    q->capacity = capacity;
    q->front = 0;
    q->rear = -1; // rear points to the last element added
    q->size = 0;
}

void Queue_enqueue(Queue* q, int val) {
    if (q->size == q->capacity) {
        // Double capacity if full
        int new_capacity = q->capacity * 2;
        int* new_arr = (int*)malloc(new_capacity * sizeof(int));
        for(int i = 0; i < q->size; ++i) {
            new_arr[i] = q->arr[(q->front + i) % q->capacity];
        }
        free(q->arr);
        q->arr = new_arr;
        q->capacity = new_capacity;
        q->front = 0;
        q->rear = q->size - 1; // Rear is now at the end of the new array
    }
    q->rear = (q->rear + 1) % q->capacity;
    q->arr[q->rear] = val;
    q->size++;
}

int Queue_dequeue(Queue* q) {
    int val = q->arr[q->front];
    q->front = (q->front + 1) % q->capacity;
    q->size--;
    return val;
}

bool Queue_isEmpty(Queue* q) {
    return q->size == 0;
}

void Queue_free(Queue* q) {
    if (q->arr) {
        free(q->arr);
        q->arr = NULL;
    }
    q->front = 0;
    q->rear = -1;
    q->size = 0;
    q->capacity = 0;
}

void add_string_to_temp_list(char*** temp_list, int* temp_size, int* temp_capacity, char* str) {
    if (*temp_size == *temp_capacity) {
        *temp_capacity = (*temp_capacity == 0) ? 16 : (*temp_capacity * 2);
        *temp_list = (char**)realloc(*temp_list, *temp_capacity * sizeof(char*));
    }
    (*temp_list)[(*temp_size)++] = str;
}

int compare_char_ptr(const void* a, const void* b) {
    return strcmp(*(char**)a, *(char**)b);
}

void build_unique_string_map(char** recipes, int recipesSize, char*** ingredients, int ingredientsSize, int* ingredientsColSize, char** supplies, int suppliesSize) {
    char** temp_all_strings = NULL;
    int temp_all_strings_size = 0;
    int temp_all_strings_capacity = 0;

    // Collect all recipe names
    for (int i = 0; i < recipesSize; i++) {
        add_string_to_temp_list(&temp_all_strings, &temp_all_strings_size, &temp_all_strings_capacity, recipes[i]);
    }
    // Collect all ingredient names
    for (int i = 0; i < ingredientsSize; i++) {
        for (int j = 0; j < ingredientsColSize[i]; j++) {
            add_string_to_temp_list(&temp_all_strings, &temp_all_strings_size, &temp_all_strings_capacity, ingredients[i][j]);
        }
    }
    // Collect all supply names
    for (int i = 0; i < suppliesSize; i++) {
        add_string_to_temp_list(&temp_all_strings, &temp_all_strings_size, &temp_all_strings_capacity, supplies[i]);
    }

    // Sort the collected strings
    qsort(temp_all_strings, temp_all_strings_size, sizeof(char*), compare_char_ptr);

    // Deduplicate and populate g_unique_strings_arr
    // Max possible size is temp_all_strings_size
    g_unique_strings_arr = (char**)malloc(temp_all_strings_size * sizeof(char*));

    if (temp_all_strings_size > 0) {
        g_unique_strings_arr[0] = temp_all_strings[0];
        g_num_unique_strings = 1;

        for (int i = 1; i < temp_all_strings_size; i++) {
            if (strcmp(temp_all_strings[i], g_unique_strings_arr[g_num_unique_strings - 1]) != 0) {
                g_unique_strings_arr[g_num_unique_strings] = temp_all_strings[i];
                g_num_unique_strings++;
            }
        }
    }
    free(temp_all_strings); // Free the temporary array of pointers
}

int get_id(char* s) {
    char** found = (char**)bsearch(&s, g_unique_strings_arr, g_num_unique_strings, sizeof(char*), compare_char_ptr);
    if (found) {
        return (int)(((char**)found - g_unique_strings_arr));
    }
    return -1; // Should not happen if all strings are pre-collected
}

void free_unique_string_map() {
    if (g_unique_strings_arr) {
        free(g_unique_strings_arr);
        g_unique_strings_arr = NULL;
        g_num_unique_strings = 0;
    }
}

char** findPossibleRecipes(char** recipes, int recipesSize, char*** ingredients, int ingredientsSize, int* ingredientsColSize, char** supplies, int suppliesSize, int* returnSize) {
    // 1. Build a mapping from all unique strings (recipes, ingredients, supplies) to integer IDs.
    //    IDs are 0-indexed indices in the sorted g_unique_strings_arr.
    build_unique_string_map(recipes, recipesSize, ingredients, ingredientsSize, ingredientsColSize, supplies, suppliesSize);

    int num_items = g_num_unique_strings;

    // 2. Initialize graph data structures using integer IDs.
    // in_degree[id] stores the count of ingredients needed for recipe 'id' that are NOT YET available.
    int* in_degree = (int*)calloc(num_items, sizeof(int)); // calloc initializes to 0

    // adj[ingredient_id] stores a list of recipe_ids that require this ingredient_id.
    IntVector* adj = (IntVector*)malloc(num_items * sizeof(IntVector));
    for (int i = 0; i < num_items; i++) {
        IntVector_init(&adj[i]);
    }

    // is_recipe_id[id] is true if 'id' corresponds to a recipe name.
    bool* is_recipe_id = (bool*)calloc(num_items, sizeof(bool)); // calloc initializes to false

    // 3. Populate in_degree and adjacency list.
    for (int i = 0; i < recipesSize; i++) {
        int recipe_id = get_id(recipes[i]);
        is_recipe_id[recipe_id] = true;
        for (int j = 0; j < ingredientsColSize[i]; j++) {
            int ingredient_id = get_id(ingredients[i][j]);
            in_degree[recipe_id]++; // Increment count of required ingredients for this recipe
            IntVector_add(&adj[ingredient_id], recipe_id); // Add recipe to the list of dependents for this ingredient
        }
    }

    // 4. Initialize the queue with all initially available supplies.
    Queue q;
    // Capacity for queue should be at least num_items. Problem guarantees recipesSize >= 1, so num_items >= 1.
    Queue_init(&q, num_items); 

    for (int i = 0; i < suppliesSize; i++) {
        int supply_id = get_id(supplies[i]);
        Queue_enqueue(&q, supply_id);
    }

    // 5. Perform a BFS-like topological sort.
    IntVector result_recipe_ids; // Stores IDs of recipes that can be made
    IntVector_init(&result_recipe_ids);

    while (!Queue_isEmpty(&q)) {
        int current_id = Queue_dequeue(&q);

        // If the current_id is a recipe, it means all its ingredients became available,
        // so this recipe can now be made.
        if (is_recipe_id[current_id]) {
            IntVector_add(&result_recipe_ids, current_id);
        }

        // For all recipes that depend on the current_id (which is now available):
        for (int i = 0; i < adj[current_id].size; i++) {
            int dependent_recipe_id = adj[current_id].arr[i];
            in_degree[dependent_recipe_id]--; // One more ingredient for this recipe is now available

            // If all ingredients for this dependent recipe are now available, enqueue it.
            if (in_degree[dependent_recipe_id] == 0) {
                Queue_enqueue(&q, dependent_recipe_id);
            }
        }
    }

    // 6. Convert the list of makeable recipe IDs back to their original string names.
    char** result_strings = (char**)malloc(result_recipe_ids.size * sizeof(char*));
    *returnSize = result_recipe_ids.size;

    for (int i = 0; i < result_recipe_ids.size; i++) {
        int recipe_id = result_recipe_ids.arr[i];
        // The ID is the index in g_unique_strings_arr, so we can directly retrieve the string.
        result_strings[i] = g_unique_strings_arr[recipe_id];
    }

    // 7. Clean up all allocated memory.
    free(in_degree);
    for (int i = 0; i < num_items; i++) {
        IntVector_free(&adj[i]);
    }
    free(adj);
    free(is_recipe_id);
    Queue_free(&q);
    IntVector_free(&result_recipe_ids);
    free_unique_string_map(); // Free the global string mapping

    return result_strings;
}