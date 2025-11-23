public class Solution {

import java.util.*;

public class Solution {
    public int countInterestingSubarrays(int[][] operations) {
        int count = 0;
        int current = 0;
        Set<Integer> seen = new HashSet<>();
        seen.add(current);

        for (int[] op : operations) {
            int x = op[0];
            int y = op[1];
            int z = op[2];

            for (int i = 0; i < z; i++) {
                current += x;
                if (seen.contains(current)) {
                    count++;
                } else {
                    seen.add(current);
                }
            }
        }

        return count;
    }
}
}