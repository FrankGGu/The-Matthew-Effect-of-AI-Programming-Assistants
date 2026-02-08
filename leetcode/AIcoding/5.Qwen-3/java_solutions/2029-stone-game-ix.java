public class Solution {

import java.util.*;

public class Solution {
    public boolean stoneGameIX(List<Integer> stones) {
        int count0 = 0, count1 = 0, count2 = 0;
        for (int stone : stones) {
            int mod = stone % 3;
            if (mod == 0) count0++;
            else if (mod == 1) count1++;
            else count2++;
        }

        if (count1 == 0 || count2 == 0) return false;

        if (count1 > count2) {
            return count1 - count2 > 1;
        } else {
            return count2 - count1 > 1;
        }
    }
}
}