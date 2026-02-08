public class Solution {

import java.util.*;

public class Solution {
    public int maxAbsoluteSum(int[] nums) {
        int maxEndingHere = 0;
        int maxSoFar = 0;
        int minEndingHere = 0;
        int minSoFar = 0;
        int maxAbs = 0;

        for (int num : nums) {
            maxEndingHere = Math.max(num, maxEndingHere + num);
            maxSoFar = Math.max(maxSoFar, maxEndingHere);

            minEndingHere = Math.min(num, minEndingHere + num);
            minSoFar = Math.min(minSoFar, minEndingHere);

            maxAbs = Math.max(maxAbs, Math.abs(maxSoFar), Math.abs(minSoFar));
        }

        return maxAbs;
    }
}
}