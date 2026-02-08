/**
 * Note: The returned array must be malloced, assume caller calls free().
 */
int* divisibilityArray(char* word, int m, int* returnSize) {
    int n = strlen(word);
    int* div = (int*)malloc(n * sizeof(int));
    *returnSize = n;
    long long remainder = 0;

    for (int i = 0; i < n; i++) {
        remainder = (remainder * 10 + (word[i] - '0')) % m;
        div[i] = (remainder == 0) ? 1 : 0;
    }

    return div;
}