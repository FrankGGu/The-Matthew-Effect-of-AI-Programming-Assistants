public class Solution {

import java.util.*;

public class Solution {
    public int[] findValidPositions(int n, int[] positions) {
        Set<Integer> used = new HashSet<>();
        for (int pos : positions) {
            used.add(pos);
        }

        int[] result = new int[n];
        int index = 0;

        for (int i = 1; i <= n; i++) {
            if (!used.contains(i)) {
                result[index++] = i;
            }
        }

        return result;
    }
}
}