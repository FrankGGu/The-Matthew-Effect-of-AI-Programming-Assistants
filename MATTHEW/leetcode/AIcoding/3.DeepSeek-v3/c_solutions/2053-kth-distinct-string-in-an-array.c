int findKthDistinct(char** arr, int arrSize, int k) {
    int count[1001] = {0};
    int first[1001] = {0};

    for (int i = 0; i < arrSize; i++) {
        int found = 0;
        for (int j = 0; j < i; j++) {
            if (strcmp(arr[i], arr[j]) == 0) {
                found = 1;
                count[j]++;
                break;
            }
        }
        if (!found) {
            first[i] = 1;
            count[i] = 1;
        }
    }

    int distinctCount = 0;
    for (int i = 0; i < arrSize; i++) {
        if (first[i] && count[i] == 1) {
            distinctCount++;
            if (distinctCount == k) {
                return i;
            }
        }
    }

    return -1;
}

char* kthDistinct(char** arr, int arrSize, int k) {
    int index = findKthDistinct(arr, arrSize, k);
    if (index == -1) {
        return "";
    }
    return arr[index];
}