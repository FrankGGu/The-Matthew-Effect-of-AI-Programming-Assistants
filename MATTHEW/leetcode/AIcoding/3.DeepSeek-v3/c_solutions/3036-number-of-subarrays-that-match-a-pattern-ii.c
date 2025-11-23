int countMatchingSubarrays(int* nums, int numsSize, int* pattern, int patternSize) {
    int n = numsSize - 1;
    int arr[n];
    for (int i = 0; i < n; i++) {
        if (nums[i + 1] > nums[i]) arr[i] = 1;
        else if (nums[i + 1] == nums[i]) arr[i] = 0;
        else arr[i] = -1;
    }

    int m = patternSize;
    int lps[m];
    lps[0] = 0;
    int len = 0;
    int i = 1;
    while (i < m) {
        if (pattern[i] == pattern[len]) {
            len++;
            lps[i] = len;
            i++;
        } else {
            if (len != 0) {
                len = lps[len - 1];
            } else {
                lps[i] = 0;
                i++;
            }
        }
    }

    int res = 0;
    i = 0;
    int j = 0;
    while (i < n) {
        if (pattern[j] == arr[i]) {
            i++;
            j++;
        }
        if (j == m) {
            res++;
            j = lps[j - 1];
        } else if (i < n && pattern[j] != arr[i]) {
            if (j != 0) {
                j = lps[j - 1];
            } else {
                i++;
            }
        }
    }
    return res;
}