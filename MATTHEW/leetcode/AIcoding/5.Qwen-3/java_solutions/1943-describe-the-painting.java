public class Solution {

import java.util.*;

public class Solution {
    public List<List<Integer>> describePainting(int[][] painting) {
        int n = painting.length;
        Map<Integer, Integer> map = new HashMap<>();
        for (int[] p : painting) {
            map.put(p[0], map.getOrDefault(p[0], 0) + p[2]);
            map.put(p[1], map.getOrDefault(p[1], 0) - p[2]);
        }

        List<Map.Entry<Integer, Integer>> list = new ArrayList<>(map.entrySet());
        list.sort(Map.Entry.comparingByKey());

        List<List<Integer>> result = new ArrayList<>();
        int prev = list.get(0).getKey();
        int current = 0;

        for (int i = 0; i < list.size(); i++) {
            int key = list.get(i).getKey();
            int val = list.get(i).getValue();

            if (i > 0 && key != prev) {
                result.add(Arrays.asList(prev, key, current));
            }

            current += val;
            prev = key;
        }

        return result;
    }
}
}