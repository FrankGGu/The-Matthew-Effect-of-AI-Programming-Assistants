import java.util.*;

class Solution {
    public long[] getDistances(int[] arr) {
        Map<Integer, List<Integer>> map = new HashMap<>();
        for (int i = 0; i < arr.length; i++) {
            if (!map.containsKey(arr[i])) {
                map.put(arr[i], new ArrayList<>());
            }
            map.get(arr[i]).add(i);
        }

        long[] result = new long[arr.length];
        for (int i = 0; i < arr.length; i++) {
            List<Integer> indices = map.get(arr[i]);
            long sum = 0;
            for (int index : indices) {
                sum += Math.abs(index - i);
            }
            result[i] = sum;
        }

        return result;
    }
}