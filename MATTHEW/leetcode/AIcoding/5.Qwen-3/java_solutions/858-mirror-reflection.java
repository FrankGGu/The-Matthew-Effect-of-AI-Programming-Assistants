public class Solution {
    public int mirrorReflection(int e, int w) {
        int m = e;
        int n = w;
        while (m % 2 == 0 && n % 2 == 0) {
            m /= 2;
            n /= 2;
        }
        if (m % 2 == 0 && n % 2 == 1) {
            return 0;
        } else if (m % 2 == 1 && n % 2 == 0) {
            return 1;
        } else {
            return 2;
        }
    }
}