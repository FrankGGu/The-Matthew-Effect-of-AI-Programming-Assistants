public class Solution {

import java.util.*;

public class Solution {
    public int countCompleteDayPairs(int[] time, int k) {
        Map<Integer, Integer> remainderCount = new HashMap<>();
        int count = 0;

        for (int t : time) {
            int rem = t % k;
            int complement = (k - rem) % k;
            count += remainderCount.getOrDefault(complement, 0);
            remainderCount.put(rem, remainderCount.getOrDefault(rem, 0) + 1);
        }

        return count;
    }
}
}