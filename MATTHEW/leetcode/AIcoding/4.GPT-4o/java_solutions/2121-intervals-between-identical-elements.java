import java.util.HashMap;
import java.util.Map;

class Solution {
    public long[] getDistances(int[] arr) {
        Map<Integer, long[]> map = new HashMap<>();
        long[] result = new long[arr.length];

        for (int i = 0; i < arr.length; i++) {
            if (!map.containsKey(arr[i])) {
                map.put(arr[i], new long[] {0, 0}); // {sum, count}
            }
            long[] data = map.get(arr[i]);
            data[0] += i; // sum of indices
            data[1]++; // count
        }

        for (int i = 0; i < arr.length; i++) {
            long[] data = map.get(arr[i]);
            result[i] = (data[0] - i * data[1]) + (i * data[1] - data[0]);
        }

        return result;
    }
}