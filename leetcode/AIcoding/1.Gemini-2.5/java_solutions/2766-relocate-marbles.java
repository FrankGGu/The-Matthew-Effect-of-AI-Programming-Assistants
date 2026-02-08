import java.util.ArrayList;
import java.util.Collections;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

class Solution {
    public List<Integer> relocateMarbles(int[] nums, int[] moveFrom, int[] moveTo) {
        Set<Integer> marblePositions = new HashSet<>();
        for (int num : nums) {
            marblePositions.add(num);
        }

        for (int i = 0; i < moveFrom.length; i++) {
            marblePositions.remove(moveFrom[i]);
            marblePositions.add(moveTo[i]);
        }

        List<Integer> result = new ArrayList<>(marblePositions);
        Collections.sort(result);

        return result;
    }
}