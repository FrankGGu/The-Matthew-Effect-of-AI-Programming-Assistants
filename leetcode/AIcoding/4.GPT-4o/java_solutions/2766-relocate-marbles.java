import java.util.*;

class Solution {
    public int[] relocateMarbles(int[] marbles, int target) {
        Set<Integer> positions = new HashSet<>();
        for (int marble : marbles) {
            positions.add(marble);
        }
        positions.remove(target);
        positions.add(target);

        List<Integer> result = new ArrayList<>(positions);
        Collections.sort(result);

        return result.stream().mapToInt(i -> i).toArray();
    }
}