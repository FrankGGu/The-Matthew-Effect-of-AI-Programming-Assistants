class Solution {
    public boolean validUtf8(int[] data) {
        int remainingBytes = 0;
        for (int value : data) {
            if (remainingBytes == 0) {
                if ((value >> 7) == 0) {
                    continue;
                } else if ((value >> 5) == 0b110) {
                    remainingBytes = 1;
                } else if ((value >> 4) == 0b1110) {
                    remainingBytes = 2;
                } else if ((value >> 3) == 0b11110) {
                    remainingBytes = 3;
                } else {
                    return false;
                }
            } else {
                if ((value >> 6) != 0b10) {
                    return false;
                }
                remainingBytes--;
            }
        }
        return remainingBytes == 0;
    }
}