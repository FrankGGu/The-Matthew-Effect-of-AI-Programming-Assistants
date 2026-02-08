public class Solution {
    public int modExp(int a, int b, int m) {
        int result = 1;
        a = a % m;
        while (b > 0) {
            if (b % 2 == 1) {
                result = (result * a) % m;
            }
            a = (a * a) % m;
            b = b / 2;
        }
        return result;
    }
}