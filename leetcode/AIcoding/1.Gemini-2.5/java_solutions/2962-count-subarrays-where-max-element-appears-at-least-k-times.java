import java.util.Arrays;

class Solution {
    public long countSubarrays(int[] nums, int k) {
        int maxElement = 0;
        for (int num : nums) {
            maxElement = Math.max(maxElement, num);
        }

        long ans = 0;
        int left = 0;
        int freq = 0; 
        int n = nums.length;

        for (int right = 0; right < n; right++) {
            if (nums[right] == maxElement) {
                freq++;
            }

            while (freq >= k) {
                ans += (n - right); 

                if (nums[left] == maxElement) {
                    freq--;
                }
                left++;
            }
        }
        return ans;
    }
}