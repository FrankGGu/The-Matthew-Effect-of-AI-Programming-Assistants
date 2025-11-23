public class Solution {
    public int superPow(int n, int k) {
        int result = 1;
        while (k > 0) {
            if (k % 2 == 1) {
                result = (result * n) % 1337;
            }
            n = (n * n) % 1337;
            k = k / 2;
        }
        return result;
    }
}