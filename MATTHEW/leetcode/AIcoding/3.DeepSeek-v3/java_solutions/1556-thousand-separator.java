class Solution {
    public String thousandSeparator(int n) {
        String s = Integer.toString(n);
        StringBuilder sb = new StringBuilder();
        int len = s.length();
        for (int i = 0; i < len; i++) {
            if (i > 0 && (len - i) % 3 == 0) {
                sb.append('.');
            }
            sb.append(s.charAt(i));
        }
        return sb.toString();
    }
}