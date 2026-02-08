#include <stdlib.h>
#include <string.h>
#include <limits.h>

typedef struct {
    int start;
    int end;
} Substring;

int compareSubstrings(const void *a, const void *b) {
    Substring *subA = (Substring *)a;
    Substring *subB = (Substring *)b;

    if (subA->end != subB->end) {
        return subA->end - subB->end;
    }
    return subA->start - subB->start;
}

int max(int a, int b) {
    return a > b ? a : b;
}

int min(int a, int b) {
    return a < b ? a : b;
}

char** maxNumOfSubstrings(char* s, int* returnSize) {
    int n = strlen(s);

    int first_occurrence[26];
    int last_occurrence[26];

    for (int i = 0; i < 26; i++) {
        first_occurrence[i] = n;
        last_occurrence[i] = -1;
    }

    for (int i = 0; i < n; i++) {
        int char_idx = s[i] - 'a';
        first_occurrence[char_idx] = min(first_occurrence[char_idx], i);
        last_occurrence[char_idx] = i;
    }

    Substring* candidates = NULL;
    int candidate_count = 0;
    int candidate_capacity = 0;

    for (int i = 0; i < n; i++) {
        if (i != first_occurrence[s[i] - 'a']) {
            continue;
        }

        int current_start = i;
        int current_end = last_occurrence[s[i] - 'a'];
        int possible = 1;

        for (int j = i; j <= current_end; j++) {
            if (first_occurrence[s[j] - 'a'] < current_start) {
                possible = 0;
                break;
            }
            current_end = max(current_end, last_occurrence[s[j] - 'a']);
        }

        if (possible) {
            if (candidate_count == candidate_capacity) {
                candidate_capacity = (candidate_capacity == 0) ? 1 : candidate_capacity * 2;
                Substring* new_candidates = (Substring*)realloc(candidates, candidate_capacity * sizeof(Substring));
                if (new_candidates == NULL) {
                    free(candidates);
                    *returnSize = 0;
                    return NULL;
                }
                candidates = new_candidates;
            }
            candidates[candidate_count].start = current_start;
            candidates[candidate_count].end = current_end;
            candidate_count++;
        }
    }

    qsort(candidates, candidate_count, sizeof(Substring), compareSubstrings);

    char** result = (char**)malloc(n * sizeof(char*));
    if (result == NULL) {
        free(candidates);
        *returnSize = 0;
        return NULL;
    }
    int result_idx = 0;
    int last_end = -1;

    for (int i = 0; i < candidate_count; i++) {
        if (candidates[i].start > last_end) {
            int length = candidates[i].end - candidates[i].start + 1;
            result[result_idx] = (char*)malloc((length + 1) * sizeof(char));
            if (result[result_idx] == NULL) {
                for (int k = 0; k < result_idx; k++) {
                    free(result[k]);
                }
                free(result);
                free(candidates);
                *returnSize = 0;
                return NULL;
            }
            strncpy(result[result_idx], s + candidates[i].start, length);
            result[result_idx][length] = '\0';

            result_idx++;
            last_end = candidates[i].end;
        }
    }

    free(candidates);
    *returnSize = result_idx;
    return result;
}