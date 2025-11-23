class Solution {
    public int maximumBinaryString(String binary) {
        int n = binary.length();
        int firstZero = -1;
        int zeroCount = 0;

        for (int i = 0; i < n; i++) {
            if (binary.charAt(i) == '0') {
                zeroCount++;
                if (firstZero == -1) {
                    firstZero = i;
                }
            }
        }

        if (zeroCount <= 1) {
            return Integer.parseInt(binary, 2);
        }

        int k = firstZero + zeroCount - 1;
        StringBuilder sb = new StringBuilder();
        for (int i = 0; i < n; i++) {
            if (i == k) {
                sb.append('0');
            } else {
                sb.append('1');
            }
        }

        return Integer.parseInt(sb.toString(), 2);
    }
}