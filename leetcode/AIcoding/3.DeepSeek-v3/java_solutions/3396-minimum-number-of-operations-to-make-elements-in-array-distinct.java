import java.util.Arrays;
import java.util.HashMap;

class Solution {
    public int minOperations(int[] nums) {
        Arrays.sort(nums);
        int n = nums.length;
        int maxFreq = 0;
        HashMap<Integer, Integer> freq = new HashMap<>();
        int left = 0;

        for (int right = 0; right < n; right++) {
            freq.put(nums[right], freq.getOrDefault(nums[right], 0) + 1);
            while (nums[right] - nums[left] >= n) {
                freq.put(nums[left], freq.get(nums[left]) - 1);
                if (freq.get(nums[left]) == 0) {
                    freq.remove(nums[left]);
                }
                left++;
            }
            maxFreq = Math.max(maxFreq, freq.get(nums[right]));
        }

        return n - maxFreq;
    }
}