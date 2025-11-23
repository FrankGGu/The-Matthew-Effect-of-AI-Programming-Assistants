class Solution {
    public boolean validUtf8(int[] data) {
        int bytesToProcess = 0;

        for (int num : data) {
            if (bytesToProcess == 0) {
                if ((num & 0xE0) == 0xC0) {
                    bytesToProcess = 1;
                } else if ((num & 0xF0) == 0xE0) {
                    bytesToProcess = 2;
                } else if ((num & 0xF8) == 0xF0) {
                    bytesToProcess = 3;
                } else if ((num & 0x80) != 0) {
                    return false;
                }
            } else {
                if ((num & 0xC0) != 0x80) {
                    return false;
                }
                bytesToProcess--;
            }
        }

        return bytesToProcess == 0;
    }
}