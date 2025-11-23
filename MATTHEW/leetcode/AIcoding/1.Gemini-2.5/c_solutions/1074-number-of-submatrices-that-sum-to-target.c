#include <stdlib.h> // For malloc, calloc, free

typedef struct Node {
    int key;
    int val;
    struct Node* next;
} Node;

typedef struct {
    Node** table;
    int capacity;
} HashMap;

static int hash(int key, int capacity) {
    return (key % capacity + capacity) % capacity;
}

static HashMap* createHashMap(int capacity) {
    HashMap* map = (HashMap*)malloc(sizeof(HashMap));
    map->capacity = capacity;
    map->table = (Node**)calloc(capacity, sizeof(Node*));
    return map;
}

static void put(HashMap* map, int key, int val) {
    int index = hash(key, map->capacity);
    Node* current = map->table[index];
    while (current != NULL) {
        if (current->key == key) {
            current->val = val;
            return;
        }
        current = current->next;
    }
    Node* newNode = (Node*)malloc(sizeof(Node));
    newNode->key = key;
    newNode->val = val;
    newNode->next = map->table[index];
    map->table[index] = newNode;
}

static int get(HashMap* map, int key) {
    int index = hash(key, map->capacity);
    Node* current = map->table[index];
    while (current != NULL) {
        if (current->key == key) {
            return current->val;
        }
        current = current->next;
    }
    return 0;
}

static void freeHashMap(HashMap* map) {
    for (int i = 0; i < map->capacity; i++) {
        Node* current = map->table[i];
        while (current != NULL) {
            Node* temp = current;
            current = current->next;
            free(temp);
        }
    }
    free(map->table);
    free(map);
}

int numSubmatrixSumTarget(int** matrix, int matrixSize, int* matrixColSize, int target) {
    int rows = matrixSize;
    int cols = matrixColSize[0];
    int count = 0;

    int** ps = (int**)calloc(rows + 1, sizeof(int*));
    for (int i = 0; i <= rows; i++) {
        ps[i] = (int*)calloc(cols + 1, sizeof(int));
    }

    for (int r = 0; r < rows; r++) {
        for (int c = 0; c < cols; c++) {
            ps[r + 1][c + 1] = matrix[r][c] + ps[r][c + 1] + ps[r + 1][c] - ps[r][c];
        }
    }

    for (int r1 = 0; r1 < rows; r1++) {
        for (int r2 = r1; r2 < rows; r2++) {
            HashMap* map = createHashMap(203); // A prime number capacity for hash map
            put(map, 0, 1); // Initialize for the case where current_sum == target
            int current_sum = 0;

            for (int c = 0; c < cols; c++) {
                // Calculate the sum of elements in the current column 'c'
                // from row 'r1' to row 'r2' using the 2D prefix sum array.
                // This is equivalent to sum of rectangle matrix[r1...r2][c...c]
                int col_sum = ps[r2 + 1][c + 1] - ps[r1][c + 1] - ps[r2 + 1][c] + ps[r1][c];
                current_sum += col_sum;

                count += get(map, current_sum - target);
                put(map, current_sum, get(map, current_sum) + 1);
            }
            freeHashMap(map);
        }
    }

    for (int i = 0; i <= rows; i++) {
        free(ps[i]);
    }
    free(ps);

    return count;
}