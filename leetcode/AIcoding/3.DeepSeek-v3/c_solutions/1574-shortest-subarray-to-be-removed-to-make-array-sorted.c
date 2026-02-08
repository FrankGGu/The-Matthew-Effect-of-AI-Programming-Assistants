int findLengthOfShortestSubarray(int* arr, int arrSize) {
    int left = 0;
    while (left + 1 < arrSize && arr[left] <= arr[left + 1]) {
        left++;
    }

    if (left == arrSize - 1) {
        return 0;
    }

    int right = arrSize - 1;
    while (right > 0 && arr[right - 1] <= arr[right]) {
        right--;
    }

    int result = (arrSize - left - 1) < right ? (arrSize - left - 1) : right;

    int i = 0, j = right;
    while (i <= left && j < arrSize) {
        if (arr[i] <= arr[j]) {
            result = (j - i - 1) < result ? (j - i - 1) : result;
            i++;
        } else {
            j++;
        }
    }

    return result;
}