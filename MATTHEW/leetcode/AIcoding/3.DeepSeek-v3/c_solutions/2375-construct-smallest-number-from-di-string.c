int* smallestNumber(char* pattern, int* returnSize) {
    int n = strlen(pattern);
    *returnSize = n + 1;
    int* result = (int*)malloc((n + 1) * sizeof(int));

    for (int i = 0; i <= n; i++) {
        result[i] = i + 1;
    }

    int i = 0;
    while (i < n) {
        if (pattern[i] == 'D') {
            int j = i;
            while (i < n && pattern[i] == 'D') {
                i++;
            }
            int left = j;
            int right = i;
            while (left < right) {
                int temp = result[left];
                result[left] = result[right];
                result[right] = temp;
                left++;
                right--;
            }
        } else {
            i++;
        }
    }

    return result;
}