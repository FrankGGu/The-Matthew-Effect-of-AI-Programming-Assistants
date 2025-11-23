class Solution {
    public int methodChaining(int[] nums) {
        if (nums == null || nums.length == 0) {
            return 0;
        }
        int max = 0;
        for (int num : nums) {
            int count = 0;
            int current = num;
            while (current != 1) {
                if (current % 2 == 0) {
                    current /= 2;
                } else {
                    current = 3 * current + 1;
                }
                count++;
            }
            max = Math.max(max, count);
        }
        return max;
    }
}