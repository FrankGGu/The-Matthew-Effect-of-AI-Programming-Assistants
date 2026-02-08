public class Solution {
    public boolean validUtf8(int[] data) {
        int count = 0;
        for (int num : data) {
            if (count == 0) {
                if ((num & 0x80) == 0) continue;
                else if ((num & 0xE0) == 0xC0) count = 1;
                else if ((num & 0xF0) == 0xD0) count = 2;
                else if ((num & 0xF8) == 0xF0) count = 3;
                else return false;
            } else {
                if ((num & 0xC0) != 0x80) return false;
                count--;
            }
        }
        return count == 0;
    }
}