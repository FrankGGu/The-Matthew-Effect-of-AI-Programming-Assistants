class Solution {
    public String removeDigit(String number, char digit) {
        String maxResult = null;
        for (int i = 0; i < number.length(); i++) {
            if (number.charAt(i) == digit) {
                String newNumber = number.substring(0, i) + number.substring(i + 1);
                if (maxResult == null || newNumber.compareTo(maxResult) > 0) {
                    maxResult = newNumber;
                }
            }
        }
        return maxResult;
    }
}