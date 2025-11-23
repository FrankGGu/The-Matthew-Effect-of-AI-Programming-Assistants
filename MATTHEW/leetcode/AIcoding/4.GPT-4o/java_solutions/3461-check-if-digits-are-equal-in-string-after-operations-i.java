class Solution {
    public boolean areDigitsEqual(String num) {
        char firstDigit = num.charAt(0);
        for (char digit : num.toCharArray()) {
            if (digit != firstDigit) {
                return false;
            }
        }
        return true;
    }
}