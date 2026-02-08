class Solution {
    public int findMaximumXOR(int[] nums) {
        int max_xor = 0;
        int mask = 0;
        for (int i = 31; i >= 0; i--) {
            mask |= (1 << i);
            HashSet<Integer> prefixes = new HashSet<>();
            for (int num : nums) {
                prefixes.add(num & mask);
            }
            int temp = max_xor | (1 << i);
            for (int prefix : prefixes) {
                if (prefixes.contains(temp ^ prefix)) {
                    max_xor = temp;
                    break;
                }
            }
        }
        return max_xor;
    }
}