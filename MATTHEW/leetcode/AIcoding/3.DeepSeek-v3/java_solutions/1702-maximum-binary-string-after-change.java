class Solution {
    public String maximumBinaryString(String binary) {
        char[] chars = binary.toCharArray();
        int n = chars.length;
        int firstZero = -1;
        int zeroCount = 0;

        for (int i = 0; i < n; i++) {
            if (chars[i] == '0') {
                zeroCount++;
                if (firstZero == -1) {
                    firstZero = i;
                }
            }
        }

        if (zeroCount <= 1) {
            return binary;
        }

        int pos = firstZero + zeroCount - 1;
        for (int i = 0; i < n; i++) {
            if (i == pos) {
                chars[i] = '0';
            } else {
                chars[i] = '1';
            }
        }

        return new String(chars);
    }
}