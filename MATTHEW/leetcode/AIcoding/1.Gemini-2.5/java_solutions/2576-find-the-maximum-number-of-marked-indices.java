import java.util.Arrays;

class Solution {
    public int maxNumOfMarkedIndices(int[] nums) {
        int n = nums.length;
        Arrays.sort(nums);

        int count = 0;
        int i = 0; // Pointer for the first half (smaller elements)
        int j = n / 2; // Pointer for the second half (larger elements)

        while (i < n / 2 && j < n) {
            if (nums[i] * 2 <= nums[j]) {
                // Found a valid pair, mark both indices
                count++;
                i++;
                j++;
            } else {
                // nums[j] is too small for nums[i].
                // We need a larger element for nums[i], so advance j.
                // nums[i] remains available to be paired with a larger element.
                j++;
            }
        }

        return count * 2;
    }
}