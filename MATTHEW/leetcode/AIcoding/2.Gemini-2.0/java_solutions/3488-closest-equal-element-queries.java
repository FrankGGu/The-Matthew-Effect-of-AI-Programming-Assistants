import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

class Solution {
    public int[] closestEqualElements(int[] arr, int[][] queries) {
        Map<Integer, List<Integer>> map = new HashMap<>();
        for (int i = 0; i < arr.length; i++) {
            if (!map.containsKey(arr[i])) {
                map.put(arr[i], new ArrayList<>());
            }
            map.get(arr[i]).add(i);
        }

        int[] result = new int[queries.length];
        for (int i = 0; i < queries.length; i++) {
            int left = queries[i][0];
            int right = queries[i][1];
            int value = arr[left];
            if (!map.containsKey(value)) {
                result[i] = -1;
                continue;
            }

            List<Integer> indices = map.get(value);
            int closest = Integer.MAX_VALUE;
            boolean found = false;
            for (int index : indices) {
                if (index >= left && index <= right) {
                    closest = Math.min(closest, Math.abs(index - left));
                    found = true;
                }
            }

            if (found) {
                result[i] = closest;
            } else {
                result[i] = -1;
            }
        }

        return result;
    }
}