public class Solution {

import java.util.*;

public class Solution {
    public int minBoxes(int[] rotations) {
        int n = rotations.length;
        int[] count = new int[26];
        for (int i = 0; i < n; i++) {
            count[rotations[i]]++;
        }
        int result = 0;
        for (int i = 0; i < 26; i++) {
            if (count[i] > 0) {
                result += count[i];
            }
        }
        return result;
    }
}
}