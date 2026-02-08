class Solution {
    public int minOperations(int n, int target) {
        int operations = 0;
        for (int i = 0; i < n; i++) {
            operations += Math.abs((i + 1) - (target - i));
        }
        return operations / 2;
    }
}