#include <stdlib.h>
#include <string.h>
#include <stdbool.h>
#include <limits.h> // For INT_MAX

#define MAX_WORDS 5002
#define MAX_WORD_LEN 11 // 10 chars + null terminator

char *g_id_to_word[MAX_WORDS];
int g_word_count;
int g_word_len;

int *g_parents[MAX_WORDS];
int g_parents_sizes[MAX_WORDS];      // Current number of parents for each word
int g_parents_capacities[MAX_WORDS]; // Allocated capacity for parent lists

char **g_current_path_words;
int g_current_path_len;
int g_current_path_capacity;

char ***g_result_paths;
int *g_result_column_sizes;
int g_result_count;
int g_result_capacity;

int compare_strings(const void *a, const void *b) {
    return strcmp(*(const char **)a, *(const char **)b);
}

void add_parent(int child_id, int parent_id) {
    if (g_parents_sizes[child_id] == g_parents_capacities[child_id]) {
        g_parents_capacities[child_id] = g_parents_capacities[child_id] == 0 ? 2 : g_parents_capacities[child_id] * 2;
        g_parents[child_id] = (int *)realloc(g_parents[child_id], sizeof(int) * g_parents_capacities[child_id]);
    }
    g_parents[child_id][g_parents_sizes[child_id]++] = parent_id;
}

void dfs(int current_id, int begin_id) {
    // Add the current word (by its string pointer) to the temporary path.
    if (g_current_path_len == g_current_path_capacity) {
        g_current_path_capacity = g_current_path_capacity == 0 ? 10 : g_current_path_capacity * 2;
        g_current_path_words = (char **)realloc(g_current_path_words, sizeof(char *) * g_current_path_capacity);
    }
    g_current_path_words[g_current_path_len++] = g_id_to_word[current_id];

    // Base case: If we reached the beginWord, a path is complete.
    if (current_id == begin_id) {
        // Expand results storage if needed.
        if (g_result_count == g_result_capacity) {
            g_result_capacity = g_result_capacity == 0 ? 10 : g_result_capacity * 2;
            g_result_paths = (char ***)realloc(g_result_paths, sizeof(char **) * g_result_capacity);
            g_result_column_sizes = (int *)realloc(g_result_column_sizes, sizeof(int) * g_result_capacity);
        }

        // Allocate memory for the new path and store its length.
        g_result_paths[g_result_count] = (char **)malloc(sizeof(char *) * g_current_path_len);
        g_result_column_sizes[g_result_count] = g_current_path_len;

        // Paths are built from end to beginning, so copy in reverse order.
        for (int i = 0; i < g_current_path_len; ++i) {
            g_result_paths[g_result_count][i] = g_current_path_words[g_current_path_len - 1 - i];
        }
        g_result_count++;
    } else {
        // Recursively call DFS for each parent of the current word.
        for (int i = 0; i < g_parents_sizes[current_id]; ++i) {
            dfs(g_parents[current_id][i], begin_id);
        }
    }

    // Backtrack: remove the current word from the temporary path.
    g_current_path_len--;
}

char*** findLadders(char * beginWord, char * endWord, char ** wordList, int wordListSize, int* returnSize, int** returnColumnSizes){
    // Reset global state for each test case.
    g_word_count = 0;
    g_word_len = strlen(beginWord);
    g_current_path_len = 0;
    g_current_path_capacity = 0;
    g_result_count = 0;
    g_result_capacity = 0;
    g_result_paths = NULL;
    g_result_column_sizes = NULL;
    g_current_path_words = NULL;

    // Initialize parent lists to empty.
    for (int i = 0; i < MAX_WORDS; ++i) {
        if (g_parents[i] != NULL) { // Free any previously allocated memory from prior test cases
            free(g_parents[i]);
        }
        g_parents[i] = NULL;
        g_parents_sizes[i] = 0;
        g_parents_capacities[i] = 0;
    }

    // 1. Collect all unique words and map them to integer IDs.
    // Use a temporary array to collect all relevant words.
    char *all_unique_words_temp[MAX_WORDS];
    bool end_word_in_list = false;

    // Add beginWord to the temporary list.
    all_unique_words_temp[g_word_count++] = beginWord;

    // Add words from wordList to the temporary list and check for endWord.
    for (int i = 0; i < wordListSize; ++i) {
        if (strcmp(wordList[i], endWord) == 0) {
            end_word_in_list = true;
        }
        all_unique_words_temp[g_word_count++] = wordList[i];
    }

    // If endWord was not in wordList, add it.
    if (!end_word_in_list) {
        all_unique_words_temp[g_word_count++] = endWord;
    }

    // Sort the temporary list to easily remove duplicates and map words to unique IDs.
    qsort(all_unique_words_temp, g_word_count, sizeof(char*), compare_strings);

    // Populate g_id_to_word with unique words and update g_word_count.
    int current_unique_idx = 0;
    if (g_word_count > 0) { // Handle case where wordList is empty and beginWord/endWord are same
        g_id_to_word[current_unique_idx++] = all_unique_words_temp[0];
        for (int i = 1; i < g_word_count; ++i) {
            if (strcmp(all_unique_words_temp[i], all_unique_words_temp[i-1]) != 0) {
                g_id_to_word[current_unique_idx++] = all_unique_words_temp[i];
            }
        }
    }
    g_word_count = current_unique_idx; // Update the actual count of unique words.

    // Get the integer IDs for beginWord and endWord.
    int begin_id = -1, end_id = -1;
    for (int i = 0; i < g_word_count; ++i) {
        if (strcmp(g_id_to_word[i], beginWord) == 0) begin_id = i;
        if (strcmp(g_id_to_word[i], endWord) == 0) end_id = i;
    }

    // If endWord is not in our unique word set (e.g., if wordList was empty and endWord != beginWord),
    // or if beginWord itself wasn't found (shouldn't happen with current logic), return empty.
    if (begin_id == -1 || end_id == -1) {
        *returnSize = 0;
        *returnColumnSizes = NULL;
        return NULL;
    }

    // 2. BFS to find shortest distances and build parent relationships.
    int dist[MAX_WORDS]; // Stores the shortest distance from beginWord_id to each word_id.
    for (int i = 0; i < g_word_count; ++i) {
        dist[i] = INT_MAX; // Initialize all distances to infinity.
    }

    int queue[MAX_WORDS]; // BFS queue, storing word IDs.
    int q_front = 0, q_rear = 0;

    dist[begin_id] = 0;
    queue[q_rear++] = begin_id;

    bool found_end = false;
    int min_dist_to_end = INT_MAX; // Stores the shortest distance found to endWord.

    while (q_front < q_rear) {
        int curr_id = queue[q_front++];
        char *curr_word = g_id_to_word[curr_id];

        // Optimization: If current path is already longer than the shortest path found to endWord,
        // we can stop exploring this branch (and subsequent branches at this level).
        if (dist[curr_id] > min_dist_to_end) {
            break;
        }

        // If we reached the endWord, record its distance and mark that it's found.
        // We continue to process other nodes at the same distance, but don't explore *from* end_id
        // to avoid paths longer than the shortest.
        if (curr_id == end_id) {
            found_end = true;
            min_dist_to_end = dist[curr_id];
            continue;
        }

        // Generate all possible one-letter-different neighbors.
        char temp_word[MAX_WORD_LEN];
        strcpy(temp_word, curr_word);

        for (int i = 0; i < g_word_len; ++i) {
            char original_char = temp_word[i];
            for (char c = 'a'; c <= 'z'; ++c) {
                if (c == original_char) continue; // Skip if character is the same.
                temp_word[i] = c;

                // Check if the generated word exists in our unique word set.
                char *search_key = temp_word;
                char **found_ptr = (char **)bsearch(&search_key, g_id_to_word, g_word_count, sizeof(char*), compare_strings);

                if (found_ptr != NULL) {
                    int neighbor_id = (int)(found_ptr - g_id_to_word); // Get the ID of the neighbor.

                    // If a shorter path to neighbor_id is found:
                    if (dist[neighbor_id] > dist[curr_id] + 1) {
                        dist[neighbor_id] = dist[curr_id] + 1;
                        // Clear previous parents as a new shortest path is found.
                        g_parents_sizes[neighbor_id] = 0;
                        add_parent(neighbor_id, curr_id);
                        queue[q_rear++] = neighbor_id; // Add neighbor to queue for further exploration.
                    }
                    // If an equally short path to neighbor_id is found:
                    else if (dist[neighbor_id] == dist[curr_id] + 1) {
                        add_parent(neighbor_id, curr_id); // Add current_id as another parent.
                    }
                }
            }
            temp_word[i] = original_char; // Backtrack character change for the next position.
        }
    }

    // If endWord was not reachable from beginWord, return an empty list.
    if (!found_end) {
        *returnSize = 0;
        *returnColumnSizes = NULL;
        // Free internal allocated memory before returning.
        for (int i = 0; i < g_word_count; ++i) {
            if (g_parents[i] != NULL) free(g_parents[i]);
        }
        return NULL;
    }

    // 3. DFS to reconstruct all shortest paths using the parent relationships.
    dfs(end_id, begin_id);

    // Set the return values for the caller.
    *returnSize = g_result_count;
    *returnColumnSizes = g_result_column_sizes;

    // Free internal temporary memory.
    for (int i = 0; i < g_word_count; ++i) {
        if (g_parents[i] != NULL) free(g_parents[i]);
    }
    if (g_current_path_words != NULL) free(g_current_path_words);

    return g_result_paths;
}