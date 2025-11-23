int maxTurbulenceSize(int* arr, int arrSize) {
    if (arrSize == 1) return 1;

    int max_len = 1;
    int left = 0;

    for (int right = 1; right < arrSize; right++) {
        int cmp = (arr[right-1] > arr[right]) ? 1 : (arr[right-1] < arr[right]) ? -1 : 0;

        if (cmp == 0) {
            left = right;
        } else if (right == arrSize - 1 || cmp * ((arr[right] > arr[right+1]) ? 1 : (arr[right] < arr[right+1]) ? -1 : 0) != -1) {
            max_len = fmax(max_len, right - left + 1);
            left = right;
        }
    }

    return max_len;
}