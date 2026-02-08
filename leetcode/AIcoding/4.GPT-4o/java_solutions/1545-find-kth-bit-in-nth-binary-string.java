class Solution {
    public char findKthBit(int n, int k) {
        String s = "0";
        for (int i = 1; i < n; i++) {
            s = s + "1" + reverseAndInvert(s);
        }
        return s.charAt(k - 1);
    }

    private String reverseAndInvert(String s) {
        StringBuilder sb = new StringBuilder();
        for (int i = s.length() - 1; i >= 0; i--) {
            sb.append(s.charAt(i) == '0' ? '1' : '0');
        }
        return sb.toString();
    }
}