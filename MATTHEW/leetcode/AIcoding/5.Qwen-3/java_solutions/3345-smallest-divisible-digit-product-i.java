public class Solution {
    public int smallestDivisible(int n) {
        for (int i = 1; i <= 9; i++) {
            if (n % i == 0) {
                return i;
            }
        }
        return -1;
    }
}