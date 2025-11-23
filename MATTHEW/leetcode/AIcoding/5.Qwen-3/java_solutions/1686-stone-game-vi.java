public class Solution {

import java.util.Arrays;
import java.util.Comparator;

public class Solution {
    public int stoneGameIX(int[] stones) {
        int[] count = new int[3];
        for (int stone : stones) {
            count[stone % 3]++;
        }

        if (count[0] % 2 == 0) {
            return Math.min(count[1], count[2]) * 2;
        } else {
            return Math.min(count[1], count[2]) * 2 + 1;
        }
    }
}
}