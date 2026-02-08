#include <stdlib.h> // For malloc and free

int lengthOfLNDS(int* arr, int arrSize, int start_idx, int k) {
    // 'tails' array stores the smallest tail of all non-decreasing subsequences
    // of length i+1.
    // The maximum possible length of any subsequence is arrSize.
    int* tails = (int*)malloc(arrSize * sizeof(int));
    int len = 0; // Current length of the LNDS

    // Iterate through the elements of the specific k-subsequence
    for (int i = start_idx; i < arrSize; i += k) {
        int num = arr[i];

        // Perform binary search to find the correct position for 'num' in 'tails'.
        // We are looking for the first element in 'tails' that is strictly greater than 'num'.
        // If such an element is found, 'num' can potentially form a non-decreasing subsequence
        // of the same length but with a smaller tail, which is always better.
        // If 'num' is greater than or equal to all elements in 'tails', it extends the LNDS.
        int low = 0, high = len;
        while (low < high) {
            int mid = low + (high - low) / 2;
            if (tails[mid] <= num) { // For non-decreasing subsequence
                low = mid + 1;
            } else {
                high = mid;
            }
        }
        // 'low' is now the index where 'num' should be placed.
        // If 'low' equals 'len', it means 'num' is greater than or equal to all
        // elements in 'tails', so it extends the LNDS by one.
        if (low == len) {
            tails[len++] = num;
        } else {
            // Otherwise, 'num' replaces tails[low], forming a non-decreasing subsequence
            // of the same length but with a smaller tail.
            tails[low] = num;
        }
    }

    free(tails); // Free the dynamically allocated memory
    return len;  // The length of the LNDS
}

int kIncreasing(int* arr, int arrSize, int k) {
    int total_operations = 0;

    // Iterate through each of the 'k' independent subsequences
    for (int i = 0; i < k; ++i) {
        int subsequence_len = 0;
        // Calculate the length of the current k-subsequence
        for (int j = i; j < arrSize; j += k) {
            subsequence_len++;
        }

        // If the subsequence is empty (e.g., arrSize < k for some i), skip it.
        // This check is mostly for robustness, practically subsequence_len will be >= 1
        // if arrSize > 0.
        if (subsequence_len == 0) {
            continue;
        }

        // Find the length of the Longest Non-Decreasing Subsequence (LNDS)
        // for the current k-subsequence.
        int lnds_len = lengthOfLNDS(arr, arrSize, i, k);

        // The number of operations needed for this subsequence is its total length
        // minus the length of its LNDS.
        total_operations += (subsequence_len - lnds_len);
    }

    return total_operations;
}