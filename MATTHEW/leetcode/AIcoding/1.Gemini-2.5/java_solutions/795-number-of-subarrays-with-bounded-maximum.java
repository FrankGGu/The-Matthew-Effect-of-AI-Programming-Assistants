class Solution {
    public long numSubarrayBoundedMax(int[] nums, int L, int R) {
        long count = 0;
        int prevInvalid = -1; // Index of the last element encountered that is greater than R
        int prevValidStart = -1; // Index of the last element encountered that is within [L, R]

        for (int i = 0; i < nums.length; i++) {
            if (nums[i] > R) {
                // If current element is greater than R, it cannot be part of any valid subarray.
                // Reset prevInvalid to current index, and reset prevValidStart.
                prevInvalid = i;
                prevValidStart = -1; 
            } else if (nums[i] >= L) {
                // If current element is within [L, R], it can be the maximum of a valid subarray.
                // Update prevValidStart to current index.
                // All subarrays ending at 'i' and starting from 'prevInvalid + 1' up to 'i'
                // will have their maximum in [L, R]. The number of such subarrays is 'i - prevInvalid'.
                prevValidStart = i;
                count += (i - prevInvalid);
            } else { // nums[i] < L
                // If current element is less than L, it cannot be the maximum of a valid subarray,
                // but it can be part of one.
                // If there's a 'prevValidStart' (an element >= L and <= R) before 'i'
                // and after 'prevInvalid', then any subarray ending at 'i'
                // and starting from 'prevInvalid + 1' up to 'prevValidStart'
                // will have its maximum in [L, R].
                // The number of such subarrays is 'prevValidStart - prevInvalid'.
                if (prevValidStart != -1) {
                    count += (prevValidStart - prevInvalid);
                }
            }
        }
        return count;
    }
}