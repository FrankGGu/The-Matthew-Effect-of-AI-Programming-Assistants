class Solution {
    public boolean canDistribute(int[] nums, int[] quantity) {
        int n = nums.length;
        int m = quantity.length;
        int total = 0;
        for (int num : quantity) total += num;
        if (total > n) return false;

        int[] count = new int[101];
        for (int num : nums) count[num]++;

        return backtrack(count, quantity, 0, m);
    }

    private boolean backtrack(int[] count, int[] quantity, int index, int m) {
        if (index == m) return true;
        for (int i = 0; i < count.length; i++) {
            if (count[i] >= quantity[index]) {
                count[i] -= quantity[index];
                if (backtrack(count, quantity, index + 1, m)) return true;
                count[i] += quantity[index];
            }
        }
        return false;
    }
}