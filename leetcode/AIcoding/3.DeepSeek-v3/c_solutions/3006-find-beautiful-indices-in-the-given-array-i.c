/**
 * Note: The returned array must be malloced, assume caller calls free().
 */
int* beautifulIndices(char* s, char* a, char* b, int k, int* returnSize) {
    int s_len = strlen(s);
    int a_len = strlen(a);
    int b_len = strlen(b);

    int* a_indices = (int*)malloc(s_len * sizeof(int));
    int* b_indices = (int*)malloc(s_len * sizeof(int));
    int a_count = 0;
    int b_count = 0;

    for (int i = 0; i <= s_len - a_len; i++) {
        if (strncmp(s + i, a, a_len) == 0) {
            a_indices[a_count++] = i;
        }
    }

    for (int i = 0; i <= s_len - b_len; i++) {
        if (strncmp(s + i, b, b_len) == 0) {
            b_indices[b_count++] = i;
        }
    }

    int* result = (int*)malloc(a_count * sizeof(int));
    int result_count = 0;

    for (int i = 0; i < a_count; i++) {
        int found = 0;
        for (int j = 0; j < b_count; j++) {
            if (abs(a_indices[i] - b_indices[j]) <= k) {
                found = 1;
                break;
            }
        }
        if (found) {
            result[result_count++] = a_indices[i];
        }
    }

    free(a_indices);
    free(b_indices);

    *returnSize = result_count;
    return result;
}