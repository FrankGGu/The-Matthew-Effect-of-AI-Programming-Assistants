public class Solution {
    public String findLexicographicallySmallestString(int a, int b) {
        StringBuilder sb = new StringBuilder();
        while (a > 0 || b > 0) {
            if (a > 0 && b > 0) {
                if (a < b) {
                    sb.append('a');
                    a--;
                } else {
                    sb.append('b');
                    b--;
                }
            } else if (a > 0) {
                sb.append('a');
                a--;
            } else {
                sb.append('b');
                b--;
            }
        }
        return sb.toString();
    }
}