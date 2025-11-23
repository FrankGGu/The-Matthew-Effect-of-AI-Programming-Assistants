class Solution {
    public String reverseDegree(String s, int k) {
        if (s == null || s.length() <= 1 || k <= 0) {
            return s;
        }

        int n = s.length();
        k = k % n;

        if (k == 0) {
            return s;
        }

        StringBuilder sb = new StringBuilder();
        sb.append(s.substring(n - k));
        sb.append(s.substring(0, n - k));

        return sb.toString();
    }
}