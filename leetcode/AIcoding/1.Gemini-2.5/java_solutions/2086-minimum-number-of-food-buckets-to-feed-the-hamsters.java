class Solution {
    public int minimumBuckets(String hamsters) {
        char[] arr = hamsters.toCharArray();
        int n = arr.length;
        int buckets = 0;

        for (int i = 0; i < n; i++) {
            if (arr[i] == 'H') {
                // Check if already fed by a bucket to its left
                if (i > 0 && arr[i-1] == 'B') {
                    continue;
                }

                // Try to place a bucket to the right
                // This is optimal as it can feed the current hamster and potentially the one after the bucket.
                if (i + 1 < n && arr[i+1] == '.') {
                    arr[i+1] = 'B'; // Place bucket
                    buckets++;
                    // Skip the bucket position (i+1) and the potentially fed hamster at (i+2)
                    // The loop's i++ will then make i point to i+3.
                    i += 2; 
                }
                // If cannot place to the right, try to place to the left
                else if (i > 0 && arr[i-1] == '.') {
                    arr[i-1] = 'B'; // Place bucket
                    buckets++;
                }
                // If neither is possible, this hamster cannot be fed
                else {
                    return -1;
                }
            }
        }
        return buckets;
    }
}