class Solution {
    public String findEncryptedString(String s, int[] left, int[] right) {
        int n = s.length();
        StringBuilder sb = new StringBuilder(s);
        for (int i = 0; i < left.length; i++) {
            reverse(sb, left[i], right[i]);
        }
        return sb.toString();
    }

    private void reverse(StringBuilder sb, int left, int right) {
        while (left < right) {
            char temp = sb.charAt(left);
            sb.setCharAt(left, sb.charAt(right));
            sb.setCharAt(right, temp);
            left++;
            right--;
        }
    }
}