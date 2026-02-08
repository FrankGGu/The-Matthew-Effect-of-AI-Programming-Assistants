class Solution {
    public String maximumNumber(String num, int[] change) {
        char[] chars = num.toCharArray();
        int n = chars.length;
        boolean started = false;

        for (int i = 0; i < n; i++) {
            int digit = chars[i] - '0';
            if (change[digit] > digit) {
                chars[i] = (char) (change[digit] + '0');
                started = true;
            } else if (change[digit] == digit) {
                if (started) {
                    chars[i] = (char) (change[digit] + '0');
                }
            }
            else if (started) {
                break;
            }
        }

        return new String(chars);
    }
}