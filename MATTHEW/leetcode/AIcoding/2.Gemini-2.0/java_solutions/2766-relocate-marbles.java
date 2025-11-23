import java.util.HashSet;
import java.util.List;
import java.util.Set;
import java.util.ArrayList;
import java.util.Collections;

class Solution {
    public List<Integer> relocateMarbles(int[] nums, int[] moveFrom, int[] moveTo) {
        Set<Integer> marbles = new HashSet<>();
        for (int num : nums) {
            marbles.add(num);
        }

        for (int i = 0; i < moveFrom.length; i++) {
            if (marbles.contains(moveFrom[i])) {
                marbles.remove(moveFrom[i]);
                marbles.add(moveTo[i]);
            }
        }

        List<Integer> result = new ArrayList<>(marbles);
        Collections.sort(result);
        return result;
    }
}