class Solution {
    public int countSubarrays(int[] nums, int k) {
        int n = nums.length;
        int pos = 0;
        for (int i = 0; i < n; i++) {
            if (nums[i] == k) {
                pos = i;
                break;
            }
        }

        Map<Integer, Integer> balanceCount = new HashMap<>();
        balanceCount.put(0, 1);
        int balance = 0;
        int res = 0;

        for (int i = 0; i < n; i++) {
            if (nums[i] < k) {
                balance--;
            } else if (nums[i] > k) {
                balance++;
            }

            if (i < pos) {
                balanceCount.put(balance, balanceCount.getOrDefault(balance, 0) + 1);
            } else {
                res += balanceCount.getOrDefault(balance, 0);
                res += balanceCount.getOrDefault(balance - 1, 0);
            }
        }

        return res;
    }
}