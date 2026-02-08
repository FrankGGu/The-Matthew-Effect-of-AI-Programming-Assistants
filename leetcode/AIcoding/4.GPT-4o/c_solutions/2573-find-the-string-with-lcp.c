char * findTheString(int n, int* arr, int arrSize) {
    char *result = (char *)malloc((n + 1) * sizeof(char));
    int i, j;

    for (i = 0; i < n; i++) {
        result[i] = 'a' + i;
    }
    result[n] = '\0';

    for (i = 0; i < arrSize; i++) {
        int index = arr[i];
        if (index >= 0 && index < n) {
            result[index] = 'a' + (n + 1);
        }
    }

    for (i = 0; i < n; i++) {
        if (result[i] == 'a' + (n + 1)) {
            result[i] = 'b';
        }
    }

    return result;
}