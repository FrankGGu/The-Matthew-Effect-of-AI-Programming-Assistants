public class Solution {
    public String strWithout3a3b(int a, int b) {
        StringBuilder result = new StringBuilder();
        while (a > 0 || b > 0) {
            boolean chooseA = false;
            if (a >= b && a > 0) {
                chooseA = true;
            } else if (b > 0) {
                chooseA = false;
            }
            if (chooseA) {
                result.append('a');
                a--;
                if (a > 0 && a == b) {
                    result.append('a');
                    a--;
                }
            } else {
                result.append('b');
                b--;
                if (b > 0 && b == a) {
                    result.append('b');
                    b--;
                }
            }
        }
        return result.toString();
    }
}