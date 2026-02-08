/**
 * Return an array of size *returnSize.
 * Note: The returned array must be malloced, assume caller calls free().
 */
char** removeInvalidParentheses(char* s, int* returnSize) {
    int len = strlen(s);
    int left_remove = 0, right_remove = 0;

    for (int i = 0; i < len; i++) {
        if (s[i] == '(') {
            left_remove++;
        } else if (s[i] == ')') {
            if (left_remove > 0) {
                left_remove--;
            } else {
                right_remove++;
            }
        }
    }

    int max_len = len - left_remove - right_remove;
    if (max_len == 0) {
        char** result = malloc(sizeof(char*));
        result[0] = malloc(1);
        result[0][0] = '\0';
        *returnSize = 1;
        return result;
    }

    char** result = malloc(1000 * sizeof(char*));
    *returnSize = 0;

    char* path = malloc(len + 1);

    void dfs(int idx, int left_count, int right_count, int left_rem, int right_rem) {
        if (idx == len) {
            if (left_rem == 0 && right_rem == 0) {
                path[max_len] = '\0';
                for (int i = 0; i < *returnSize; i++) {
                    if (strcmp(result[i], path) == 0) return;
                }
                result[*returnSize] = malloc(max_len + 1);
                strcpy(result[*returnSize], path);
                (*returnSize)++;
            }
            return;
        }

        char c = s[idx];
        if ((c == '(' && left_rem > 0) || (c == ')' && right_rem > 0)) {
            dfs(idx + 1, left_count, right_count, 
                left_rem - (c == '(' ? 1 : 0), 
                right_rem - (c == ')' ? 1 : 0));
        }

        path[left_count + right_count] = c;

        if (c != '(' && c != ')') {
            dfs(idx + 1, left_count, right_count, left_rem, right_rem);
        } else if (c == '(') {
            dfs(idx + 1, left_count + 1, right_count, left_rem, right_rem);
        } else if (right_count < left_count) {
            dfs(idx + 1, left_count, right_count + 1, left_rem, right_rem);
        }
    }

    dfs(0, 0, 0, left_remove, right_remove);

    free(path);

    if (*returnSize == 0) {
        result = realloc(result, sizeof(char*));
        result[0] = malloc(1);
        result[0][0] = '\0';
        *returnSize = 1;
    }

    return result;
}