public class Solution {

import java.util.*;

public class Solution {
    public boolean mergeTriplets(int[][] triplets, int[] target) {
        Set<Integer> usedIndices = new HashSet<>();
        for (int i = 0; i < triplets.length; i++) {
            if (triplets[i][0] > target[0] || triplelets[i][1] > target[1] || triplets[i][2] > target[2]) {
                continue;
            }
            for (int j = 0; j < 3; j++) {
                if (triplets[i][j] == target[j]) {
                    usedIndices.add(j);
                }
            }
        }
        return usedIndices.size() == 3;
    }
}
}