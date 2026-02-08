public class Solution {
    public int monkeyMove(int n) {
        int mod = 1000000007;
        long result = 1;
        for (int i = 0; i < n; i++) {
            result = (result * 2) % mod;
        }
        return (int) (result - 1 + mod) % mod;
    }
}