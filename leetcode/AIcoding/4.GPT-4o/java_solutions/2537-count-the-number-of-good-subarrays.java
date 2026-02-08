class Solution {
    public long countGood(int[] nums, int k) {
        long count = 0;
        Map<Integer, Integer> freqMap = new HashMap<>();
        int left = 0, pairs = 0;

        for (int right = 0; right < nums.length; right++) {
            pairs += freqMap.getOrDefault(nums[right], 0);
            freqMap.put(nums[right], freqMap.getOrDefault(nums[right], 0) + 1);

            while (pairs >= k) {
                freqMap.put(nums[left], freqMap.get(nums[left]) - 1);
                pairs -= freqMap.get(nums[left]);
                left++;
            }
            count += left;
        }
        return count;
    }
}