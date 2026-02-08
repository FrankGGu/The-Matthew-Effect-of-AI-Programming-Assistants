class Solution {
    public int findKey(int[] nums) {
        int key = 0;
        for (int num : nums) {
            key ^= num;
        }
        return key;
    }
}