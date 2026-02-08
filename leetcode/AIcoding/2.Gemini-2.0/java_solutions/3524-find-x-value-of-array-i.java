class Solution {
    public int findX(int[] nums) {
        int x = 0;
        for (int num : nums) {
            x = 2 * x + num;
        }
        return x;
    }
}