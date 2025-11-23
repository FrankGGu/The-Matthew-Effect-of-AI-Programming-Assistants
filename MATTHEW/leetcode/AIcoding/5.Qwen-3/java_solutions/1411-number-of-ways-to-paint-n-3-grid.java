public class Solution {
    public int numOfWays(int n) {
        int a = 2, b = 2;
        for (int i = 1; i < n; i++) {
            int newA = (a * 2 + b * 2) % (1000000007);
            int newB = (a * 1 + b * 3) % (1000000007);
            a = newA;
            b = newB;
        }
        return (a + b) % (1000000007);
    }
}