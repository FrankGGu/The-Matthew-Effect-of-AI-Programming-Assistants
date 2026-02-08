#include <stdio.h>
#include <stdlib.h>
#include <string.h> // For strlen, strcpy, strcmp

#define N_MAX 101 // For n from 1 to 100, array size N_MAX for remainders 0 to n-1.

#define Q_MAX (N_MAX * N_MAX) 

typedef struct {
    char* num_str; // Dynamically allocated string representing the number
    int rem_x;     // num_str % n
    int rem_prod;  // (product of digits of num_str) % n
} State;

State queue[Q_MAX];
int head = 0;
int tail = 0;

void enqueue(char* num_str, int rem_x, int rem_prod) {
    queue[tail].num_str = num_str; // num_str must be a newly allocated string (e.g., from custom_strdup or malloc)
    queue[tail].rem_x = rem_x;
    queue[tail].rem_prod = rem_prod;
    tail = (tail + 1) % Q_MAX;
}

State dequeue() {
    State s = queue[head];
    head = (head + 1) % Q_MAX;
    return s;
}

int is_queue_empty() {
    return head == tail;
}

char* visited[N_MAX][N_MAX];

int compare_num_strings(const char* s1, const char* s2) {
    size_t len1 = strlen(s1);
    size_t len2 = strlen(s2);
    if (len1 < len2) return -1;
    if (len1 > len2) return 1;
    return strcmp(s1, s2);
}

char* custom_strdup(const char* s) {
    size_t len = strlen(s);
    char* new_s = (char*)malloc(len + 1);
    if (new_s == NULL) return NULL;
    strcpy(new_s, s);
    return new_s;
}

char* smallestDivisibleDigitProduct(int n) {
    // Handle edge case n=1
    if (n == 1) {
        char* result = (char*)malloc(2 * sizeof(char));
        if (result == NULL) return NULL; // Handle malloc failure
        strcpy(result, "1");
        return result;
    }

    // Initialize visited array with NULL
    for (int i = 0; i < n; ++i) {
        for (int j = 0; j < n; ++j) {
            visited[i][j] = NULL;
        }
    }

    head = 0;
    tail = 0;

    // Start BFS with single-digit numbers (1-9)
    for (int d = 1; d <= 9; ++d) {
        char* current_s = (char*)malloc(2 * sizeof(char)); // For single digit + null terminator
        if (current_s == NULL) {
            // Clean up any previously allocated strings in visited before returning NULL
            for (int i = 0; i < n; ++i) {
                for (int j = 0; j < n; ++j) {
                    if (visited[i][j] != NULL) free(visited[i][j]);
                }
            }
            return NULL; // Malloc failure
        }
        current_s[0] = d + '0';
        current_s[1] = '\0';

        int rem_x = d % n;
        int rem_prod = d % n;

        // If this state has not been visited, or we found a smaller number for this state
        if (visited[rem_x][rem_prod] == NULL || compare_num_strings(current_s, visited[rem_x][rem_prod]) < 0) {
            if (visited[rem_x][rem_prod] != NULL) {
                free(visited[rem_x][rem_prod]); // Free the old string
            }
            visited[rem_x][rem_prod] = custom_strdup(current_s); // Store a copy
            if (visited[rem_x][rem_prod] == NULL) { free(current_s); return NULL; } // Malloc failure
            enqueue(current_s, rem_x, rem_prod); // Enqueue the original string (it will be freed later)
        } else {
            free(current_s); // This string is not needed, free it
        }
    }

    char* min_solution = NULL; // Stores the smallest number string found that satisfies conditions

    while (!is_queue_empty()) {
        State curr = dequeue();
        char* curr_s = curr.num_str; // This string was enqueued and needs to be freed at the end of this iteration
        int curr_rem_x = curr.rem_x;
        int curr_rem_prod = curr.rem_prod;

        // If a number is found that is divisible by n and its digit product is divisible by n
        if (curr_rem_x == 0 && curr_rem_prod == 0) {
            if (min_solution == NULL || compare_num_strings(curr_s, min_solution) < 0) {
                if (min_solution != NULL) {
                    free(min_solution); // Free the old solution string
                }
                min_solution = custom_strdup(curr_s); // Store a copy of the new best solution
                if (min_solution == NULL) { free(curr_s); return NULL; } // Malloc failure
            }
        }

        // Optimization: If a solution is already found and the current number's length
        // is greater than the length of the best solution, we can prune this branch.
        // If lengths are equal, and current number is lexicographically greater, also prune.
        if (min_solution != NULL) {
            int cmp = compare_num_strings(curr_s, min_solution);
            if (cmp >= 0) { // curr_s is longer or same length and lexicographically greater/equal
                free(curr_s); // Free current string as it won't lead to a better solution
                continue; // Skip extending this path
            }
        }

        // Try appending digits 1-9
        for (int d = 1; d <= 9; ++d) {
            size_t curr_s_len = strlen(curr_s);
            char* next_s = (char*)malloc((curr_s_len + 2) * sizeof(char)); // +1 for new digit, +1 for null terminator
            if (next_s == NULL) { free(curr_s); return NULL; } // Malloc failure
            strcpy(next_s, curr_s);
            next_s[curr_s_len] = d + '0';
            next_s[curr_s_len + 1] = '\0';

            int next_rem_x = (curr_rem_x * 10 + d) % n;
            int next_rem_prod = (curr_rem_prod * d) % n;

            // If this state has not been visited, or we found a smaller number for this state
            if (visited[next_rem_x][next_rem_prod] == NULL || compare_num_strings(next_s, visited[next_rem_x][next_rem_prod]) < 0) {
                if (visited[next_rem_x][next_rem_prod] != NULL) {
                    free(visited[next_rem_x][next_rem_prod]); // Free the old string
                }
                visited[next_rem_x][next_rem_prod] = custom_strdup(next_s); // Store a copy
                if (visited[next_rem_x][next_rem_prod] == NULL) { free(next_s); free(curr_s); return NULL; } // Malloc failure
                enqueue(next_s, next_rem_x, next_rem_prod); // Enqueue the original string
            } else {
                free(next_s); // This string is not needed, free it
            }
        }
        free(curr_s); // Free the current string after processing all its extensions
    }

    // Clean up visited array (free any remaining strings that were not overwritten/freed)
    for (int i = 0; i < n; ++i) {
        for (int j = 0; j < n; ++j) {
            if (visited[i][j] != NULL) {
                free(visited[i][j]);
            }
        }
    }

    if (min_solution != NULL) {
        return min_solution; // Return the best solution found
    } else {
        // No solution found. This can happen if n % 10 == 0 (no non-zero digit solution possible).
        char* result = (char*)malloc(2 * sizeof(char));
        if (result == NULL) return NULL; // Malloc failure
        strcpy(result, "-1"); // Indicate no solution
        return result;
    }
}