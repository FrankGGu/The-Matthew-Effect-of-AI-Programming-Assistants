public class Solution {
    public String removeDigit(String number, char digit) {
        int index = -1;
        for (int i = 0; i < number.length(); i++) {
            if (number.charAt(i) == digit) {
                index = i;
                if (i < number.length() - 1 && number.charAt(i + 1) > digit) {
                    break;
                }
            }
        }
        return number.substring(0, index) + number.substring(index + 1);
    }
}