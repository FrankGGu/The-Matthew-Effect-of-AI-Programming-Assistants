#include <stdlib.h>
#include <string.h>

typedef struct {
    char* pattern;
    int count;
} PatternInfo;

int cmp(const void* a, const void* b) {
    PatternInfo* pa = (PatternInfo*)a;
    PatternInfo* pb = (PatternInfo*)b;
    if (pa->count != pb->count) {
        return pb->count - pa->count;
    }
    return strcmp(pa->pattern, pb->pattern);
}

char** findRepeatedDnaSequences(char* s, int* returnSize) {
    if (strlen(s) < 10) {
        *returnSize = 0;
        return NULL;
    }

    int n = strlen(s);
    int max_patterns = n - 9;
    PatternInfo* patterns = (PatternInfo*)malloc(max_patterns * sizeof(PatternInfo));
    int pattern_count = 0;

    for (int i = 0; i <= n - 10; i++) {
        char* current = (char*)malloc(11 * sizeof(char));
        strncpy(current, s + i, 10);
        current[10] = '\0';

        int found = 0;
        for (int j = 0; j < pattern_count; j++) {
            if (strcmp(patterns[j].pattern, current) == 0) {
                patterns[j].count++;
                found = 1;
                break;
            }
        }

        if (!found) {
            patterns[pattern_count].pattern = current;
            patterns[pattern_count].count = 1;
            pattern_count++;
        } else {
            free(current);
        }
    }

    int result_count = 0;
    for (int i = 0; i < pattern_count; i++) {
        if (patterns[i].count > 1) {
            result_count++;
        }
    }

    char** result = (char**)malloc(result_count * sizeof(char*));
    int idx = 0;
    for (int i = 0; i < pattern_count; i++) {
        if (patterns[i].count > 1) {
            result[idx++] = patterns[i].pattern;
        } else {
            free(patterns[i].pattern);
        }
    }

    qsort(result, result_count, sizeof(char*), cmp);

    free(patterns);
    *returnSize = result_count;
    return result;
}