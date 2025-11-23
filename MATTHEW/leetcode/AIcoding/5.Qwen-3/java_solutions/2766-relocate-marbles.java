public class Solution {

import java.util.*;

public class Solution {
    public List<Integer> relocateMarbles(int[] nums, int[] moveFrom, int[] moveTo) {
        Set<Integer> marbles = new HashSet<>();
        for (int num : nums) {
            marbles.add(num);
        }

        for (int i = 0; i < moveFrom.length; i++) {
            int from = moveFrom[i];
            int to = moveTo[i];
            if (marbles.contains(from)) {
                marbles.remove(from);
                marbles.add(to);
            }
        }

        List<Integer> result = new ArrayList<>(marbles);
        Collections.sort(result);
        return result;
    }
}
}