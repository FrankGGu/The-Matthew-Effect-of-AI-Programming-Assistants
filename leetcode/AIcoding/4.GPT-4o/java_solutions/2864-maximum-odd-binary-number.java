class Solution {
    public String maximumOddBinaryNumber(String s) {
        int countOne = 0;
        for (char c : s.toCharArray()) {
            if (c == '1') countOne++;
        }
        int countZero = s.length() - countOne;
        StringBuilder result = new StringBuilder();
        for (int i = 0; i < countOne - 1; i++) {
            result.append('1');
        }
        if (countOne > 0) result.append('1');
        for (int i = 0; i < countZero; i++) {
            result.append('0');
        }
        return result.toString();
    }
}