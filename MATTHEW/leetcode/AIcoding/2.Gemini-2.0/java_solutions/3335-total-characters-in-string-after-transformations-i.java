class Solution {
    public int solve(int n, int[] a) {
        int sum = 0;
        for (int x : a) {
            sum += x;
        }
        return sum;
    }
}