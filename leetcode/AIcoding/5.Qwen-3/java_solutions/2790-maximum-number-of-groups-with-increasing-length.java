public class Solution {

import java.util.*;

public class Solution {
    public int maxIncreasingGroups(List<Integer> usageLimits) {
        Collections.sort(usageLimits);
        int res = 0;
        int total = 0;
        for (int limit : usageLimits) {
            total += limit;
            if (total >= (res + 1) * (res + 2) / 2) {
                res++;
            }
        }
        return res;
    }
}
}