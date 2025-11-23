class Solution {
    public String maximumBinaryString(String binary) {
        int countZero = 0;
        int n = binary.length();

        for (char c : binary.toCharArray()) {
            if (c == '0') countZero++;
        }

        if (countZero == 0) return binary;

        StringBuilder result = new StringBuilder();
        for (int i = 0; i < n - countZero - 1; i++) {
            result.append('1');
        }

        result.append('0');

        for (int i = 0; i < countZero; i++) {
            result.append('1');
        }

        return result.toString();
    }
}