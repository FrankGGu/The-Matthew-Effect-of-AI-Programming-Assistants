class Solution {
    public int maximumValue(String[] strs) {
        int maxValue = 0;
        for (String str : strs) {
            int value;
            if (str.chars().allMatch(Character::isDigit)) {
                value = Integer.parseInt(str);
            } else {
                value = str.length();
            }
            maxValue = Math.max(maxValue, value);
        }
        return maxValue;
    }
}