int* divisibilityArray(char * word, int m, int* returnSize) {
    int n = strlen(word);
    int* result = (int*)malloc(n * sizeof(int));
    long long current = 0;

    for (int i = 0; i < n; i++) {
        current = current * 10 + (word[i] - '0');
        current %= m;
        result[i] = (current == 0) ? 1 : 0;
    }

    *returnSize = n;
    return result;
}