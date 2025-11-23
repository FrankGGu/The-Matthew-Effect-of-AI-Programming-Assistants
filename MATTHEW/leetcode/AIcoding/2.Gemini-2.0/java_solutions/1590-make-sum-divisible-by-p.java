class Solution {
    public int minSubarray(int[] nums, int p) {
        int n = nums.length;
        int target = 0;
        for (int num : nums) {
            target = (target + num) % p;
        }
        if (target == 0) {
            return 0;
        }
        int minLen = n;
        int currSum = 0;
        Map<Integer, Integer> seen = new HashMap<>();
        seen.put(0, -1);
        for (int i = 0; i < n; i++) {
            currSum = (currSum + nums[i]) % p;
            int complement = (currSum - target + p) % p;
            if (seen.containsKey(complement)) {
                minLen = Math.min(minLen, i - seen.get(complement));
            }
            seen.put(currSum, i);
        }
        return minLen == n ? -1 : minLen;
    }
}