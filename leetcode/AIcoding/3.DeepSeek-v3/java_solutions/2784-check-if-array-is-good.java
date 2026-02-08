class Solution {
    public boolean isGood(int[] nums) {
        int n = nums.length;
        if (n == 0) return false;
        int max = 0;
        for (int num : nums) {
            if (num > max) {
                max = num;
            }
        }
        if (max != n - 1) return false;

        int[] count = new int[max + 1];
        for (int num : nums) {
            if (num < 1 || num > max) return false;
            count[num]++;
            if (num != max && count[num] > 1) return false;
        }
        return count[max] == 2;
    }
}