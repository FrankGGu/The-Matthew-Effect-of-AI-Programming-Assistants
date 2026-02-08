int minimumSum(int* arr, int arrSize) {
    int min_sum = 0;
    int left = 0, right = arrSize - 1;

    while (left < right) {
        min_sum += arr[left] + arr[right];
        left++;
        right--;
    }

    return min_sum;
}