#include <stddef.h> // Not strictly necessary for this problem, but useful for size_t

static int min(int a, int b) {
    return a < b ? a : b;
}

int findLengthOfShortestSubarray(int* arr, int arrSize) {
    if (arrSize <= 1) {
        return 0;
    }

    // 1. Find the end of the longest non-decreasing prefix
    // `left` will be the index of the last element in the prefix
    int left = 0;
    while (left < arrSize - 1 && arr[left] <= arr[left + 1]) {
        left++;
    }

    // If the entire array is already sorted, no elements need to be removed.
    if (left == arrSize - 1) {
        return 0;
    }

    // 2. Find the start of the longest non-decreasing suffix
    // `right` will be the index of the first element in the suffix
    int right = arrSize - 1;
    while (right > 0 && arr[right - 1] <= arr[right]) {
        right--;
    }

    // Initialize the minimum length of the subarray to be removed
    // Case A: Remove `arr[left+1 ... arrSize-1]` (keep only the prefix `arr[0...left]`)
    //   Length = `arrSize - (left + 1)`
    // Case B: Remove `arr[0 ... right-1]` (keep only the suffix `arr[right...arrSize-1]`)
    //   Length = `right`
    int ans = min(arrSize - (left + 1), right);

    // 3. Two-pointer approach for combining a prefix `arr[0...i]` and a suffix `arr[j...arrSize-1]`
    // `i` iterates through the possible end indices of the prefix part (from 0 to `left`)
    // `j` iterates through the possible start indices of the suffix part (from `right` to `arrSize-1`)
    // We need `arr[i] <= arr[j]` for the combined array to be sorted.
    int j = right;
    for (int i = 0; i <= left; ++i) {
        // Move `j` forward until `arr[i] <= arr[j]` or `j` reaches the end of the array.
        // The `j` pointer only moves forward, ensuring O(N) total complexity for this loop.
        while (j < arrSize && arr[i] > arr[j]) {
            j++;
        }

        // If `j` reached the end of the array, no more valid `j` can be found for the current `i`
        // or any subsequent `i` (since `arr[i]` would only increase or stay the same).
        if (j == arrSize) {
            break;
        }

        // Now `arr[i] <= arr[j]` (or `j` is at `arrSize`, handled by the break).
        // The elements to remove are `arr[i+1 ... j-1]`.
        // The number of elements in this subarray is `(j-1) - (i+1) + 1 = j - i - 1`.
        // If `j <= i+1`, this means the prefix and suffix overlap or touch, and no elements are removed between them.
        // In such cases, `j - i - 1` would be 0 or negative. The actual removed length is 0.
        // The `min` function will correctly pick 0 if `j - i - 1` is negative, as `ans` is initialized with non-negative values.
        ans = min(ans, j - i - 1);
    }

    return ans;
}