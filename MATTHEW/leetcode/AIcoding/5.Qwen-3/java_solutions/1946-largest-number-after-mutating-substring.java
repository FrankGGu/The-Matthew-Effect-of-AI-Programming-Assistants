public class Solution {
    public String maximumNumber(String number, int[] mapping) {
        char[] chars = number.toCharArray();
        for (int i = 0; i < chars.length; i++) {
            int digit = chars[i] - '0';
            if (digit < 10 && mapping[digit] != digit) {
                chars[i] = (char) ('0' + mapping[digit]);
            }
        }
        return new String(chars);
    }
}