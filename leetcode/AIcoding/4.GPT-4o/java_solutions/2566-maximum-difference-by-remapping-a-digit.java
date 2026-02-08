class Solution {
    public int minMaxDifference(int num) {
        String s = String.valueOf(num);
        char minDigit = '9', maxDigit = '0';
        for (char c : s.toCharArray()) {
            minDigit = (char) Math.min(minDigit, c);
            maxDigit = (char) Math.max(maxDigit, c);
        }
        String minNum = s.replace(minDigit, '0');
        String maxNum = s.replace(maxDigit, '9');
        return Integer.parseInt(maxNum) - Integer.parseInt(minNum);
    }
}