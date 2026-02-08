class Solution {
    public int[] prevPermutationWithOneSwap(int[] nums) {
        int n = nums.length;

        // Find the largest index i such that nums[i] can be swapped with some nums[j] (j > i)
        // to form a smaller permutation. This means nums[i] must be greater than nums[j].
        // To make the resulting permutation lexicographically largest while being smaller,
        // we want to modify the rightmost possible element nums[i].
        // So, we iterate i from n-2 down to 0.

        int best_i = -1;
        int best_j = -1;

        for (int i = n - 2; i >= 0; i--) {
            // For the current i, we need to find the largest nums[j] (where j > i and nums[j] < nums[i]).
            // If there are multiple such nums[j] with the same largest value, we pick the rightmost j.
            int current_max_val_less_than_Ai = -1;
            int current_best_j_for_i = -1;

            // Iterate j from n-1 down to i+1 to find the rightmost candidate j.
            for (int j = n - 1; j > i; j--) {
                if (nums[i] > nums[j]) {
                    // nums[j] is a candidate for swapping with nums[i]
                    if (nums[j] > current_max_val_less_than_Ai) {
                        // Found a larger value for nums[j] that is still less than nums[i]
                        current_max_val_less_than_Ai = nums[j];
                        current_best_j_for_i = j;
                    }
                    // If nums[j] == current_max_val_less_than_Ai, we do nothing.
                    // This is because 'j' is iterating from right to left.
                    // So, if we already have a 'current_best_j_for_i' set for 'current_max_val_less_than_Ai',
                    // it means that index 'j' was further to the right than the current 'j'.
                    // We want the rightmost 'j' for a given 'current_max_val_less_than_Ai'.
                }
            }

            // If a suitable j was found for this i, this is our best candidate pair (i, j)
            // because we are iterating i from right to left, so this is the rightmost i
            // that allows a swap to create a smaller permutation.
            if (current_best_j_for_i != -1) {
                best_i = i;
                best_j = current_best_j_for_i;
                break; // Found the rightmost 'i' that can be swapped, so we stop.
            }
        }

        // If no such i was found (best_i remains -1), it means the array is already
        // the smallest possible permutation (e.g., [1, 2, 3] or [1, 1, 5]),
        // so no smaller permutation can be formed with one swap. Return the original array.
        if (best_i != -1) {
            // Perform the swap between nums[best_i] and nums[best_j]
            int temp = nums[best_i];
            nums[best_i] = nums[best_j];
            nums[best_j] = temp;
        }

        return nums;
    }
}