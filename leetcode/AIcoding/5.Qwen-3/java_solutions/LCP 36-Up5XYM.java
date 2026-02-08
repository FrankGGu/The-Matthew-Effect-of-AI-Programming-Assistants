public class Solution {

import java.util.*;

public class Solution {
    public int maxNumberOfGroups(int[] candies) {
        Arrays.sort(candies);
        int count = 0;
        int prev = 0;
        for (int i = 0; i < candies.length; i++) {
            if (candies[i] > prev) {
                count++;
                prev = candies[i];
            }
        }
        return count;
    }
}
}