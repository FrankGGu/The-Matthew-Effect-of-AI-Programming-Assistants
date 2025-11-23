import java.util.HashMap;
import java.util.HashSet;
import java.util.Map;
import java.util.Set;

class Solution {
    public boolean canCross(int[] stones) {
        if (stones == null || stones.length == 0) {
            return false;
        }

        Map<Integer, Set<Integer>> dp = new HashMap<>();

        for (int stone : stones) {
            dp.put(stone, new HashSet<>());
        }

        dp.get(0).add(0); // Represents starting at stone 0, with a 'previous jump' of 0.
                          // This allows the first actual jump to be k+1 = 1.

        for (int stone : stones) {
            for (int k : dp.get(stone)) { // k is the size of the jump that landed on 'stone'
                for (int jump = k - 1; jump <= k + 1; jump++) {
                    if (jump > 0) { // A jump must always be forward and positive
                        int nextStone = stone + jump;
                        if (dp.containsKey(nextStone)) {
                            dp.get(nextStone).add(jump);
                        }
                    }
                }
            }
        }

        return !dp.get(stones[stones.length - 1]).isEmpty();
    }
}