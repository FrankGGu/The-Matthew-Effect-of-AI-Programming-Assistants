class Solution {
    public int climbStairs(int n) {
        if (n == 1) {
            return 1;
        }
        int a = 1; // Represents ways to reach stair 1
        int b = 2; // Represents ways to reach stair 2
        for (int i = 3; i <= n; i++) {
            int temp = a + b;
            a = b;
            b = temp;
        }
        return b;
    }
}