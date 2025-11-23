class Solution {
    public int minOperations(int[][] grid, int x) {
        List<Integer> nums = new ArrayList<>();
        for (int[] row : grid) {
            for (int num : row) {
                nums.add(num);
            }
        }
        Collections.sort(nums);
        int median = nums.get(nums.size() / 2);
        int operations = 0;
        for (int num : nums) {
            int diff = Math.abs(num - median);
            if (diff % x != 0) return -1;
            operations += diff / x;
        }
        return operations;
    }
}