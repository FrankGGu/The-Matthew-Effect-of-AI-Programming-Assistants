import java.util.Arrays;
import java.util.Comparator;
import java.util.Map;
import java.util.TreeMap;

class Solution {
    public int[] mostBeautifulItem(int[][] items, int[] queries) {
        Arrays.sort(items, Comparator.comparingInt(a -> a[0]));
        TreeMap<Integer, Integer> map = new TreeMap<>();
        int maxBeauty = 0;
        for (int[] item : items) {
            maxBeauty = Math.max(maxBeauty, item[1]);
            map.put(item[0], maxBeauty);
        }

        int[] result = new int[queries.length];
        for (int i = 0; i < queries.length; i++) {
            Map.Entry<Integer, Integer> entry = map.floorEntry(queries[i]);
            result[i] = entry == null ? 0 : entry.getValue();
        }

        return result;
    }
}