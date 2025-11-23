class Solution {
    public int findKthPositive(int[] arr, int k) {
        int low = 0;
        int high = arr.length - 1;
        int ans_idx = -1; // Stores the largest index 'i' such that arr[i] - (i + 1) < k

        while (low <= high) {
            int mid = low + (high - low) / 2;
            // The number of missing positive integers before arr[mid] is arr[mid] - (mid + 1).
            // This is because if arr[mid] were present without any missing numbers before it,
            // it would be at index mid, so its value would be (mid + 1).
            // The difference arr[mid] - (mid + 1) gives the count of missing numbers.
            if (arr[mid] - (mid + 1) < k) {
                // If the count of missing numbers before arr[mid] is less than k,
                // it means the k-th missing number is after arr[mid].
                // We record this mid as a potential answer index and search in the right half.
                ans_idx = mid;
                low = mid + 1;
            } else {
                // If the count of missing numbers before arr[mid] is k or more,
                // it means the k-th missing number is at or before arr[mid].
                // We search in the left half.
                high = mid - 1;
            }
        }

        // After the binary search, 'ans_idx' will be the largest index such that
        // the number of missing elements before arr[ans_idx] is less than 'k'.

        if (ans_idx == -1) {
            // This means even before arr[0], the number of missing elements is already k or more.
            // For example, arr = [10], k = 3. arr[0] - (0 + 1) = 9 >= 3.
            // In this case, the k-th missing number is simply k.
            return k;
        } else {
            // The number of missing elements before arr[ans_idx] is `arr[ans_idx] - (ans_idx + 1)`.
            // We need to find `k - (arr[ans_idx] - (ans_idx + 1))` more missing numbers.
            // These additional missing numbers will start from `arr[ans_idx] + 1`.
            // So, the k-th missing number is `arr[ans_idx] + (k - (arr[ans_idx] - (ans_idx + 1)))`.
            // This expression simplifies to:
            // `arr[ans_idx] + k - arr[ans_idx] + ans_idx + 1`
            // `= k + ans_idx + 1`
            return k + ans_idx + 1;
        }
    }
}