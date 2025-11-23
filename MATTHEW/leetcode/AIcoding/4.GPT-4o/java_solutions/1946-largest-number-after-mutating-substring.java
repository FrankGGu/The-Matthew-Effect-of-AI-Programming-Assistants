class Solution {
    public String maximumNumber(String num, int[] change) {
        char[] chars = num.toCharArray();
        boolean started = false;
        for (int i = 0; i < chars.length; i++) {
            int digit = chars[i] - '0';
            if (change[digit] > digit) {
                chars[i] = (char) (change[digit] + '0');
                started = true;
            } else if (change[digit] < digit && started) {
                break;
            }
        }
        return new String(chars);
    }
}