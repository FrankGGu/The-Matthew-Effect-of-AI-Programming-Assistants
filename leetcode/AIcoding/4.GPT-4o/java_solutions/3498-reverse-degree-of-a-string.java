class Solution {
    public String reverseDegree(String s, int k) {
        if (k <= 0 || k > s.length()) return s;
        StringBuilder result = new StringBuilder();
        for (int i = 0; i < s.length(); i += k) {
            int end = Math.min(i + k, s.length());
            result.append(new StringBuilder(s.substring(i, end)).reverse());
        }
        return result.toString();
    }
}