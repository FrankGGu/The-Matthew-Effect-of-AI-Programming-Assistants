class Solution {
    public String maximumOddBinaryNumber(String s) {
        int oneCount = 0;
        for (char c : s.toCharArray()) {
            if (c == '1') {
                oneCount++;
            }
        }

        StringBuilder sb = new StringBuilder();
        for (int i = 0; i < oneCount - 1; i++) {
            sb.append('1');
        }
        for (int i = 0; i < s.length() - oneCount; i++) {
            sb.append('0');
        }
        sb.append('1');

        return sb.toString();
    }
}