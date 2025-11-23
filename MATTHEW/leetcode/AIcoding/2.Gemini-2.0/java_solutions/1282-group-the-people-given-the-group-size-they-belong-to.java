import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

class Solution {
    public List<List<Integer>> groupThePeople(int[] groupSizes) {
        Map<Integer, List<Integer>> groupMap = new HashMap<>();
        List<List<Integer>> result = new ArrayList<>();

        for (int i = 0; i < groupSizes.length; i++) {
            int size = groupSizes[i];
            if (!groupMap.containsKey(size)) {
                groupMap.put(size, new ArrayList<>());
            }
            groupMap.get(size).add(i);

            if (groupMap.get(size).size() == size) {
                result.add(new ArrayList<>(groupMap.get(size)));
                groupMap.put(size, new ArrayList<>());
            }
        }

        return result;
    }
}