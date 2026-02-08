#include <stdlib.h>
#include <stdbool.h>
#include <string.h>

#define MAX_QUEUE_CAPACITY 200000 
#define MAX_RESULT_CAPACITY 100 

bool isValid(char *s) {
    int balance = 0;
    for (int i = 0; s[i] != '\0'; i++) {
        if (s[i] == '(') {
            balance++;
        } else if (s[i] == ')') {
            balance--;
        }
        if (balance < 0) {
            return false;
        }
    }
    return balance == 0;
}

typedef struct {
    char** data;
    int capacity;
    int size;
} VisitedSet;

VisitedSet* createVisitedSet(int capacity) {
    VisitedSet* set = (VisitedSet*)malloc(sizeof(VisitedSet));
    set->data = (char**)malloc(capacity * sizeof(char*));
    set->capacity = capacity;
    set->size = 0;
    return set;
}

bool visitedSetContains(VisitedSet* set, char* s) {
    for (int i = 0; i < set->size; i++) {
        if (strcmp(set->data[i], s) == 0) {
            return true;
        }
    }
    return false;
}

void visitedSetAdd(VisitedSet* set, char* s) {
    if (set->size >= set->capacity) {
        // In a production environment, this would typically involve reallocating
        // and doubling the capacity. For LeetCode, we assume MAX_QUEUE_CAPACITY
        // is sufficient for the problem constraints.
        return; 
    }
    set->data[set->size++] = strdup(s); // Store a copy of the string
}

void freeVisitedSet(VisitedSet* set) {
    for (int i = 0; i < set->size; i++) {
        free(set->data[i]); // Free each string
    }
    free(set->data); // Free the array of pointers
    free(set);       // Free the set structure itself
}

char **removeInvalidParentheses(char *s, int *returnSize) {
    char **results = (char **)malloc(MAX_RESULT_CAPACITY * sizeof(char *));
    *returnSize = 0;

    char **queue = (char **)malloc(MAX_QUEUE_CAPACITY * sizeof(char *));
    int head = 0;
    int tail = 0;

    VisitedSet* visited = createVisitedSet(MAX_QUEUE_CAPACITY);

    queue[tail++] = strdup(s); // Add initial string to queue
    visitedSetAdd(visited, s); // Add initial string to visited set

    bool found_valid_at_current_level = false;

    while (head < tail) {
        int level_size = tail - head; // Number of elements at the current level

        for (int i = 0; i < level_size; i++) {
            char *current_s = queue[head++]; // Dequeue the current string

            if (isValid(current_s)) {
                // If the string is valid, add it to results if not already present.
                // We check for duplicates in results because multiple paths might lead to the same valid string.
                bool already_in_results = false;
                for(int j = 0; j < *returnSize; j++) {
                    if (strcmp(results[j], current_s) == 0) {
                        already_in_results = true;
                        break;
                    }
                }
                if (!already_in_results) {
                    if (*returnSize >= MAX_RESULT_CAPACITY) {
                        // Reallocate results array if needed.
                        // For LeetCode, assuming MAX_RESULT_CAPACITY is sufficient.
                    }
                    results[*returnSize++] = strdup(current_s);
                }
                found_valid_at_current_level = true;
            }

            // Only generate children (by removing one parenthesis) if no valid string
            // has been found *yet* at this level. This ensures we find solutions with
            // the minimum number of removals (BFS property).
            if (!found_valid_at_current_level) {
                int len = strlen(current_s);
                for (int j = 0; j < len; j++) {
                    // Only consider removing parentheses
                    if (current_s[j] != '(' && current_s[j] != ')') {
                        continue;
                    }

                    // Optimization: Skip removing consecutive identical parentheses.
                    // E.g., for "(((" removing the first '(' yields "((". Removing the second '(' also yields "((".
                    // This optimization avoids redundant work and helps prune the search space.
                    if (j > 0 && current_s[j] == current_s[j-1]) {
                        continue;
                    }

                    // Create a new string by removing the character at index j
                    char *next_s = (char *)malloc(len); // Allocate for len-1 chars + null terminator
                    int k = 0;
                    for (int l = 0; l < len; l++) {
                        if (j == l) continue; // Skip the character to be removed
                        next_s[k++] = current_s[l];
                    }
                    next_s[k] = '\0'; // Null-terminate the new string

                    // If the new string has not been visited, add it to the visited set and enqueue it
                    if (!visitedSetContains(visited, next_s)) {
                        visitedSetAdd(visited, next_s);
                        if (tail >= MAX_QUEUE_CAPACITY) {
                            // Queue overflow. In a real scenario, reallocate.
                            // For LeetCode, assuming MAX_QUEUE_CAPACITY is sufficient.
                            free(next_s); // Prevent memory leak
                            continue;
                        }
                        queue[tail++] = next_s;
                    } else {
                        free(next_s); // String already visited, free the newly allocated memory
                    }
                }
            }
            free(current_s); // Free the string after it has been processed
        } // End of processing for the current level

        if (found_valid_at_current_level) {
            // If any valid string was found at this level, we have found all shortest valid strings.
            // Stop exploring deeper levels.
            break;
        }
    }

    // Free any remaining strings in the queue that were added but never processed
    // (This happens if the `break` statement was hit and `head < tail` still)
    while(head < tail) {
        free(queue[head++]);
    }
    free(queue); // Free the queue array itself
    freeVisitedSet(visited); // Free the visited set and all its strings

    return results; // Return the array of valid strings
}