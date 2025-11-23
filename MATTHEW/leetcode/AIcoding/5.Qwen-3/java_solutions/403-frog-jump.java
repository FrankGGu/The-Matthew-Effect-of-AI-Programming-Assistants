public class Solution {

import java.util.*;

public class Solution {
    public boolean canCross(int[] stones) {
        if (stones[0] != 0) return false;
        Map<Integer, Set<Integer>> map = new HashMap<>();
        for (int i = 0; i < stones.length; i++) {
            map.put(stones[i], new HashSet<>());
        }
        map.get(0).add(0);
        for (int i = 0; i < stones.length; i++) {
            int pos = stones[i];
            Set<Integer> jumps = map.get(pos);
            for (int j : jumps) {
                for (int k = j - 1; k <= j + 1; k++) {
                    if (k > 0 && map.containsKey(pos + k)) {
                        map.get(pos + k).add(k);
                    }
                }
            }
        }
        return !map.get(stones[stones.length - 1]).isEmpty();
    }
}
}