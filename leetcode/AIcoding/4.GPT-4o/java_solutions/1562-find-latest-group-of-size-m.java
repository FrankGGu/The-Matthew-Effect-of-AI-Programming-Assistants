import java.util.*;

class Solution {
    public List<Integer> findLatestGroup(int[] groupSizes, int m) {
        Map<Integer, List<Integer>> map = new HashMap<>();
        for (int i = 0; i < groupSizes.length; i++) {
            map.putIfAbsent(groupSizes[i], new ArrayList<>());
            map.get(groupSizes[i]).add(i + 1);
        }

        List<Integer> result = new ArrayList<>();
        for (List<Integer> indices : map.values()) {
            if (indices.size() == m) {
                result = indices;
            }
        }

        return result;
    }
}