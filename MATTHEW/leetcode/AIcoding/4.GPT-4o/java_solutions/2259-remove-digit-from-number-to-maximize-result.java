class Solution {
    public String removeDigit(String number, char digit) {
        String result = "";
        for (int i = 0; i < number.length(); i++) {
            if (number.charAt(i) == digit) {
                if (i < number.length() - 1 && number.charAt(i + 1) > digit) {
                    return number.substring(0, i) + number.substring(i + 1);
                }
                if (i > 0 && number.charAt(i - 1) < digit) {
                    result = number.substring(0, i) + number.substring(i + 1);
                }
            }
        }
        return result;
    }
}