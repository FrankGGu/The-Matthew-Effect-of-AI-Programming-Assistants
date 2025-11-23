int longestTurbulentSubarray(int* arr, int numsSize) {
    if (numsSize == 0) {
        return 0;
    }
    if (numsSize == 1) {
        return 1;
    }

    int maxLen = 1;
    int inc = 1; // Length of turbulent subarray ending with arr[i-1] < arr[i]
    int dec = 1; // Length of turbulent subarray ending with arr[i-1] > arr[i]

    for (int i = 1; i < numsSize; i++) {
        if (arr[i-1] < arr[i]) {
            inc = dec + 1;
            dec = 1;
        } else if (arr[i-1] > arr[i]) {
            dec = inc + 1;
            inc = 1;
        } else { // arr[i-1] == arr[i]
            inc = 1;
            dec = 1;
        }

        if (inc > maxLen) {
            maxLen = inc;
        }
        if (dec > maxLen) {
            maxLen = dec;
        }
    }

    return maxLen;
}