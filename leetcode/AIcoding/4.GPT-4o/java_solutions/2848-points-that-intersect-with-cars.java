import java.util.*;

public class Solution {
    public int countPoints(String rings) {
        int[] rods = new int[10];
        for (int i = 0; i < rings.length(); i += 2) {
            char color = rings.charAt(i);
            int rodIndex = rings.charAt(i + 1) - '0';
            if (color == 'R') rods[rodIndex] |= 1;
            else if (color == 'G') rods[rodIndex] |= 2;
            else if (color == 'B') rods[rodIndex] |= 4;
        }
        int count = 0;
        for (int rod : rods) {
            if (rod == 7) count++;
        }
        return count;
    }
}