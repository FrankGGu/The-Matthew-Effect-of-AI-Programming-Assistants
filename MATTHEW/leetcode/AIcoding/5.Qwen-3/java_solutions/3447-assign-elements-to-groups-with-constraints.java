public class Solution {

import java.util.*;

public class Solution {
    public int[] groupThePeople(int[] groupSizes) {
        Map<Integer, List<Integer>> map = new HashMap<>();
        int n = groupSizes.length;
        int[] result = new int[n];

        for (int i = 0; i < n; i++) {
            int size = groupSizes[i];
            map.putIfAbsent(size, new ArrayList<>());
            map.get(size).add(i);
        }

        int index = 0;
        for (Map.Entry<Integer, List<Integer>> entry : map.entrySet()) {
            int size = entry.getKey();
            List<Integer> people = entry.getValue();
            for (int i = 0; i < people.size(); i += size) {
                for (int j = 0; j < size; j++) {
                    result[people.get(i + j)] = index;
                }
                index++;
            }
        }

        return result;
    }
}
}