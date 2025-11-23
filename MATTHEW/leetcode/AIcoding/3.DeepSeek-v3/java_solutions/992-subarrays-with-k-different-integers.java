class Solution {
    public int subarraysWithKDistinct(int[] nums, int k) {
        return atMostK(nums, k) - atMostK(nums, k - 1);
    }

    private int atMostK(int[] nums, int k) {
        int res = 0;
        int left = 0;
        Map<Integer, Integer> count = new HashMap<>();
        for (int right = 0; right < nums.length; right++) {
            if (count.getOrDefault(nums[right], 0) == 0) {
                k--;
            }
            count.put(nums[right], count.getOrDefault(nums[right], 0) + 1);
            while (k < 0) {
                count.put(nums[left], count.get(nums[left]) - 1);
                if (count.get(nums[left]) == 0) {
                    k++;
                }
                left++;
            }
            res += right - left + 1;
        }
        return res;
    }
}