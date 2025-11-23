public class Solution {

import java.util.*;

public class Solution {
    public int repeatedNTimes(int[] A) {
        Set<Integer> seen = new HashSet<>();
        for (int num : A) {
            if (seen.contains(num)) {
                return num;
            }
            seen.add(num);
        }
        return -1;
    }
}
}