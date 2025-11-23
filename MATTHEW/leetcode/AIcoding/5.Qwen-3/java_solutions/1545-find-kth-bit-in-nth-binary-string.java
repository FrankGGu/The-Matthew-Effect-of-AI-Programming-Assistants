public class Solution {
    public String findKthBit(int n, int k) {
        StringBuilder sb = new StringBuilder();
        for (int i = 1; i <= n; i++) {
            sb.append('0');
            for (int j = sb.length() - 2; j >= 0; j--) {
                sb.append(sb.charAt(j) == '0' ? '1' : '0');
            }
        }
        return String.valueOf(sb.charAt(k - 1));
    }
}