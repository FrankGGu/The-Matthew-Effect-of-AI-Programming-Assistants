class Solution {
    public String strWithout3a3b(int a, int b) {
        StringBuilder sb = new StringBuilder();
        while (a > 0 || b > 0) {
            if (a > b) {
                if (sb.length() >= 2 && sb.charAt(sb.length() - 1) == 'a' && sb.charAt(sb.length() - 2) == 'a') {
                    if (b > 0) {
                        sb.append('b');
                        b--;
                    } else {
                        break;
                    }
                } else {
                    sb.append('a');
                    a--;
                }
            } else if (b > a) {
                if (sb.length() >= 2 && sb.charAt(sb.length() - 1) == 'b' && sb.charAt(sb.length() - 2) == 'b') {
                    if (a > 0) {
                        sb.append('a');
                        a--;
                    } else {
                        break;
                    }
                } else {
                    sb.append('b');
                    b--;
                }
            } else {
                if (sb.length() >= 1 && sb.charAt(sb.length() - 1) == 'a') {
                    sb.append('b');
                    b--;
                } else {
                    sb.append('a');
                    a--;
                }
            }
        }
        return sb.toString();
    }
}