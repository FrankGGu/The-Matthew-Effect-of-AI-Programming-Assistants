class Solution {
    public int minSubarray(int[] nums, int p) {
        int totalRem = 0;
        for (int num : nums) {
            totalRem = (totalRem + num) % p;
        }
        if (totalRem == 0) {
            return 0;
        }

        Map<Integer, Integer> map = new HashMap<>();
        map.put(0, -1);
        int minLen = nums.length;
        int currRem = 0;

        for (int i = 0; i < nums.length; i++) {
            currRem = (currRem + nums[i]) % p;
            int targetRem = (currRem - totalRem + p) % p;
            if (map.containsKey(targetRem)) {
                minLen = Math.min(minLen, i - map.get(targetRem));
            }
            map.put(currRem, i);
        }

        return minLen < nums.length ? minLen : -1;
    }
}