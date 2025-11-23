bool canTransform(int* arr, int arrSize) {
    long long sum = 0;
    for (int i = 0; i < arrSize; i++) {
        sum += arr[i];
    }
    return sum == 0;
}