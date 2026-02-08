class Solution {
    public int findMaximumXOR(int[] nums) {
        int maxNum = 0;
        for (int num : nums) {
            maxNum = Math.max(maxNum, num);
        }
        int mask = 0, res = 0;
        for (int i = 31; i >= 0; i--) {
            mask |= (1 << i);
            Set<Integer> prefixes = new HashSet<>();
            for (int num : nums) {
                prefixes.add(num & mask);
            }
            int candidate = res | (1 << i);
            for (int prefix : prefixes) {
                if (prefixes.contains(candidate ^ prefix)) {
                    res = candidate;
                    break;
                }
            }
        }
        return res;
    }
}