char* kthDistinct(char** arr, int arrSize, int k) {
    int count = 0;
    for (int i = 0; i < arrSize; i++) {
        int j;
        for (j = 0; j < arrSize; j++) {
            if (i != j && strcmp(arr[i], arr[j]) == 0) {
                break;
            }
        }
        if (j == arrSize) {
            count++;
            if (count == k) {
                return arr[i];
            }
        }
    }
    return "";
}