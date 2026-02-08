class Solution {
    public String maximumBinaryString(String binary) {
        int zeros = 0;
        int onesBeforeFirstZero = 0;
        int n = binary.length();

        for (int i = 0; i < n; i++) {
            if (binary.charAt(i) == '0') {
                zeros++;
            }
        }

        if (zeros == 0) {
            return binary;
        }

        StringBuilder sb = new StringBuilder();
        for (int i = 0; i < n - zeros; i++) {
            sb.append('1');
        }

        sb.append('0');

        for (int i = 0; i < zeros - 1; i++) {
            sb.append('1');
        }

        return sb.toString();
    }
}