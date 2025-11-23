class Solution {
    public int maximumValue(String[] strs) {
        int maxVal = 0;
        for (String str : strs) {
            try {
                int num = Integer.parseInt(str);
                maxVal = Math.max(maxVal, num);
            } catch (NumberFormatException e) {
                maxVal = Math.max(maxVal, str.length());
            }
        }
        return maxVal;
    }
}