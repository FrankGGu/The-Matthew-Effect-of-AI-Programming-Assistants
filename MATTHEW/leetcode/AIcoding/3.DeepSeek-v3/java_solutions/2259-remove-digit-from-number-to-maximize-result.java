class Solution {
    public String removeDigit(String number, char digit) {
        String maxResult = "";
        for (int i = 0; i < number.length(); i++) {
            if (number.charAt(i) == digit) {
                String current = number.substring(0, i) + number.substring(i + 1);
                if (maxResult.compareTo(current) < 0) {
                    maxResult = current;
                }
            }
        }
        return maxResult;
    }
}