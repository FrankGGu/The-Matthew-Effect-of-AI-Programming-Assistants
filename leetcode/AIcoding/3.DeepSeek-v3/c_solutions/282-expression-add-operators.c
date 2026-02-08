/**
 * Note: The returned array must be malloced, assume caller calls free().
 */
void backtrack(char* num, int target, char** result, int* returnSize, char* path, int path_len, long long eval, long long mult, int index) {
    if (index == strlen(num)) {
        if (eval == target) {
            path[path_len] = '\0';
            result[*returnSize] = (char*)malloc((path_len + 1) * sizeof(char));
            strcpy(result[*returnSize], path);
            (*returnSize)++;
        }
        return;
    }

    long long curr = 0;
    for (int i = index; i < strlen(num); i++) {
        if (i != index && num[index] == '0') break;

        curr = curr * 10 + (num[i] - '0');
        int curr_len = i - index + 1;

        if (index == 0) {
            strncpy(path + path_len, num + index, curr_len);
            backtrack(num, target, result, returnSize, path, path_len + curr_len, curr, curr, i + 1);
        } else {
            strncpy(path + path_len, "+", 1);
            strncpy(path + path_len + 1, num + index, curr_len);
            backtrack(num, target, result, returnSize, path, path_len + 1 + curr_len, eval + curr, curr, i + 1);

            strncpy(path + path_len, "-", 1);
            strncpy(path + path_len + 1, num + index, curr_len);
            backtrack(num, target, result, returnSize, path, path_len + 1 + curr_len, eval - curr, -curr, i + 1);

            strncpy(path + path_len, "*", 1);
            strncpy(path + path_len + 1, num + index, curr_len);
            backtrack(num, target, result, returnSize, path, path_len + 1 + curr_len, eval - mult + mult * curr, mult * curr, i + 1);
        }
    }
}

char** addOperators(char* num, int target, int* returnSize) {
    *returnSize = 0;
    if (strlen(num) == 0) return NULL;

    int max_path_len = strlen(num) * 2;
    char* path = (char*)malloc((max_path_len + 1) * sizeof(char));

    int max_results = 1000;
    char** result = (char**)malloc(max_results * sizeof(char*));

    backtrack(num, target, result, returnSize, path, 0, 0, 0, 0);

    free(path);
    return result;
}