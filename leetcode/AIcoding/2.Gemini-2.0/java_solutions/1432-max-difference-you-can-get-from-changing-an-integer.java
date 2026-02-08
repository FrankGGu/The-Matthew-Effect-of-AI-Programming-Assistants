class Solution {
    public int maxDiff(int num) {
        String s = String.valueOf(num);
        int n = s.length();

        String a = null;
        for (int i = 0; i < n; i++) {
            char c = s.charAt(i);
            if (c != '9') {
                a = s.replace(c, '9');
                break;
            }
        }
        if (a == null) {
            a = s;
        }

        String b = null;
        char first = s.charAt(0);
        if (first != '1') {
            b = s.replace(first, '1');
        } else {
            for (int i = 1; i < n; i++) {
                char c = s.charAt(i);
                if (c != '0' && c != '1') {
                    b = s.replace(c, '0');
                    break;
                }
            }
            if (b == null) {
                b = s;
            }
        }

        return Integer.parseInt(a) - Integer.parseInt(b);
    }
}