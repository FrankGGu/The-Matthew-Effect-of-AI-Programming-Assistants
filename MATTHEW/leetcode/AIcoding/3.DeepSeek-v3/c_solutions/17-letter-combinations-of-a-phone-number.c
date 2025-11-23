/**
 * Note: The returned array must be malloced, assume caller calls free().
 */
char** letterCombinations(char* digits, int* returnSize) {
    if (digits == NULL || digits[0] == '\0') {
        *returnSize = 0;
        return NULL;
    }

    char* phone[] = {
        "", "", "abc", "def", "ghi", "jkl", "mno", "pqrs", "tuv", "wxyz"
    };

    int len = strlen(digits);
    *returnSize = 1;
    for (int i = 0; i < len; i++) {
        int digit = digits[i] - '0';
        *returnSize *= strlen(phone[digit]);
    }

    char** result = (char**)malloc(*returnSize * sizeof(char*));
    for (int i = 0; i < *returnSize; i++) {
        result[i] = (char*)malloc((len + 1) * sizeof(char));
        result[i][len] = '\0';
    }

    int repeat = *returnSize;
    for (int i = 0; i < len; i++) {
        int digit = digits[i] - '0';
        char* letters = phone[digit];
        int letter_count = strlen(letters);
        repeat /= letter_count;

        for (int j = 0; j < *returnSize; j++) {
            int index = (j / repeat) % letter_count;
            result[j][i] = letters[index];
        }
    }

    return result;
}