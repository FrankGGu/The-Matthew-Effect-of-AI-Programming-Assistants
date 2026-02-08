import java.util.HashMap;
import java.util.HashSet;
import java.util.Map;
import java.util.Set;

class Solution {
    public int countPoints(String rings) {
        int[] rodMasks = new int[10]; // 0-9 rods

        for (int i = 0; i < rings.length(); i += 2) {
            char colorChar = rings.charAt(i);
            int rodIndex = rings.charAt(i + 1) - '0';

            int colorMask = 0;
            if (colorChar == 'R') {
                colorMask = 1; // 001
            } else if (colorChar == 'G') {
                colorMask = 2; // 010
            } else { // colorChar == 'B'
                colorMask = 4; // 100
            }
            rodMasks[rodIndex] |= colorMask;
        }

        int fullRodsCount = 0;
        for (int mask : rodMasks) {
            if (mask == 7) { // 111 means R, G, B are all present
                fullRodsCount++;
            }
        }

        return fullRodsCount;
    }
}