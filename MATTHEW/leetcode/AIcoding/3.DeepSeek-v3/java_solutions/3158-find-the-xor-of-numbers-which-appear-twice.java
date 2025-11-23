class Solution {
    public int duplicateNumbersXOR(int[] nums) {
        Set<Integer> seen = new HashSet<>();
        int xor = 0;
        for (int num : nums) {
            if (seen.contains(num)) {
                xor ^= num;
            } else {
                seen.add(num);
            }
        }
        return xor;
    }
}