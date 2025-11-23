public class Solution {
    public String maximumBinaryString(String binary) {
        int countZero = 0;
        for (char c : binary.toCharArray()) {
            if (c == '0') countZero++;
        }
        if (countZero == 0) return binary;

        StringBuilder result = new StringBuilder();
        result.append('1');
        for (int i = 0; i < binary.length() - countZero - 1; i++) {
            result.append('1');
        }
        for (int i = 0; i < countZero; i++) {
            result.append('0');
        }
        return result.toString();
    }
}