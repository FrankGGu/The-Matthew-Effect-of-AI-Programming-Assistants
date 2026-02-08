int* beautifulArray(int n, int* returnSize) {
    int* result = (int*)malloc(n * sizeof(int));
    int left = 0, right = n - 1;

    for (int i = 1; i <= n; i++) {
        result[i - 1] = i;
    }

    for (int i = 1; i < n; i++) {
        if (result[i] % 2 == 0) {
            int temp = result[i];
            result[i] = result[left];
            result[left] = temp;
            left++;
        }
    }

    for (int i = 0; i < n; i++) {
        if (result[i] % 2 != 0) {
            int temp = result[i];
            result[i] = result[right];
            result[right] = temp;
            right--;
        }
    }

    *returnSize = n;
    return result;
}