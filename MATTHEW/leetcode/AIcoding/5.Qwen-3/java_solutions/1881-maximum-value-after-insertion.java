public class Solution {
    public String maxValue(String s, int x) {
        StringBuilder sb = new StringBuilder(s);
        int n = s.length();
        for (int i = 0; i < n; i++) {
            if (s.charAt(i) < '0' + x) {
                sb.insert(i, x);
                return sb.toString();
            }
        }
        sb.append(x);
        return sb.toString();
    }
}