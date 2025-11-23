class Solution {
    public String thousandSeparator(int n) {
        StringBuilder sb = new StringBuilder();
        String num = Integer.toString(n);
        int len = num.length();
        for (int i = 0; i < len; i++) {
            if (i > 0 && (len - i) % 3 == 0) {
                sb.append('.');
            }
            sb.append(num.charAt(i));
        }
        return sb.toString();
    }
}