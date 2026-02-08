import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

class Solution {
    public List<List<Integer>> groupThePeople(int[] groupSizes) {
        List<List<Integer>> result = new ArrayList<>();
        Map<Integer, List<Integer>> groups = new HashMap<>();

        for (int i = 0; i < groupSizes.length; i++) {
            int size = groupSizes[i];

            groups.computeIfAbsent(size, k -> new ArrayList<>()).add(i);

            if (groups.get(size).size() == size) {
                result.add(groups.get(size));
                groups.put(size, new ArrayList<>());
            }
        }
        return result;
    }
}