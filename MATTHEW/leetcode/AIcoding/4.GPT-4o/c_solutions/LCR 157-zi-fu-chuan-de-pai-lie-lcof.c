int* findPermutation(char * s, int* returnSize) {
    int n = strlen(s);
    int* permutation = (int*)malloc((n + 1) * sizeof(int));
    for (int i = 1; i <= n; i++) {
        permutation[i] = i;
    }
    for (int i = 0; i < n; ) {
        if (s[i] == 'I') {
            i++;
        } else {
            int j = i;
            while (j < n && s[j] == 'D') {
                j++;
            }
            reverse(permutation, i, j);
            i = j;
        }
    }
    *returnSize = n + 1;
    return permutation;
}

void reverse(int* arr, int start, int end) {
    while (start < end) {
        int temp = arr[start];
        arr[start] = arr[end - 1];
        arr[end - 1] = temp;
        start++;
        end--;
    }
}