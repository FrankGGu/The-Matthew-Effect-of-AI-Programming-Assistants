import java.util.HashMap;

class Solution {
    public long countSubarrays(int[] nums, int k) {
        int n = nums.length;
        long result = 0;
        HashMap<Integer, Integer> count = new HashMap<>();
        count.put(0, 1);

        int balance = 0;
        for (int i = 0; i < n; i++) {
            if (nums[i] < k) {
                balance--;
            } else if (nums[i] > k) {
                balance++;
            }
            result += count.getOrDefault(balance, 0);
            count.put(balance, count.getOrDefault(balance, 0) + 1);
        }

        return result;
    }
}