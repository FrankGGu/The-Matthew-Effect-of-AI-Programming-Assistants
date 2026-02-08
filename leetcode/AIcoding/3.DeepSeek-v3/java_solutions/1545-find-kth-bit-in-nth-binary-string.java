class Solution {
    public char findKthBit(int n, int k) {
        String s = "0";
        for (int i = 2; i <= n; i++) {
            String inverted = invert(s);
            StringBuilder reversed = new StringBuilder(inverted).reverse();
            s = s + "1" + reversed.toString();
        }
        return s.charAt(k - 1);
    }

    private String invert(String s) {
        StringBuilder sb = new StringBuilder();
        for (char c : s.toCharArray()) {
            sb.append(c == '0' ? '1' : '0');
        }
        return sb.toString();
    }
}