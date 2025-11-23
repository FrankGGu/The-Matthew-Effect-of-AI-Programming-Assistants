class Solution {
    public int maximumValue(String[] strs) {
        int maxValue = 0;
        for (String s : strs) {
            boolean isNumeric = true;
            for (char c : s.toCharArray()) {
                if (!Character.isDigit(c)) {
                    isNumeric = false;
                    break;
                }
            }

            int currentValue;
            if (isNumeric) {
                currentValue = Integer.parseInt(s);
            } else {
                currentValue = s.length();
            }
            maxValue = Math.max(maxValue, currentValue);
        }
        return maxValue;
    }
}