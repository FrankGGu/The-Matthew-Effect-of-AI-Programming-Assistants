public class Solution {

import java.util.*;

public class Solution {
    public List<List<Integer>> findColorGroups(int[] colors, int k) {
        Map<Integer, List<Integer>> colorMap = new HashMap<>();
        for (int i = 0; i < colors.length; i++) {
            colorMap.putIfAbsent(colors[i], new ArrayList<>());
            colorMap.get(colors[i]).add(i);
        }

        List<List<Integer>> result = new ArrayList<>();
        for (Map.Entry<Integer, List<Integer>> entry : colorMap.entrySet()) {
            List<Integer> indices = entry.getValue();
            if (indices.size() >= k) {
                for (int i = 0; i <= indices.size() - k; i++) {
                    List<Integer> group = new ArrayList<>();
                    for (int j = i; j < i + k; j++) {
                        group.add(indices.get(j));
                    }
                    result.add(group);
                }
            }
        }

        return result;
    }
}
}