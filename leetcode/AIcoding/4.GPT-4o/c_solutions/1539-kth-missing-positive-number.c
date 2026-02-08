int findKthPositive(int* arr, int arrSize, int k) {
    int count = 0, current = 1, i = 0;
    while (count < k) {
        if (i < arrSize && arr[i] == current) {
            i++;
        } else {
            count++;
        }
        current++;
    }
    return current - 1;
}