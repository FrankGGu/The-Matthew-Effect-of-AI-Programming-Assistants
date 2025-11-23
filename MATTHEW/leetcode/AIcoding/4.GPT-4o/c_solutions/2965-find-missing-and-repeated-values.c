void findMissingAndRepeating(int arr[], int n, int *missing, int *repeating) {
    int i;
    for (i = 0; i < n; i++) {
        int index = abs(arr[i]) - 1;
        if (arr[index] < 0) {
            *repeating = abs(arr[i]);
        } else {
            arr[index] = -arr[index];
        }
    }
    for (i = 0; i < n; i++) {
        if (arr[i] > 0) {
            *missing = i + 1;
            break;
        }
    }
}