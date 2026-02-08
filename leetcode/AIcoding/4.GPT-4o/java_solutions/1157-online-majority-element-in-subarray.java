import java.util.HashMap;
import java.util.Map;
import java.util.TreeMap;

public class MajorityChecker {
    private int[] arr;
    private Map<Integer, TreeMap<Integer, Integer>> map;

    public MajorityChecker(int[] arr) {
        this.arr = arr;
        map = new HashMap<>();
        for (int i = 0; i < arr.length; i++) {
            map.putIfAbsent(arr[i], new TreeMap<>());
            map.get(arr[i]).put(i, map.get(arr[i]).getOrDefault(i, 0) + 1);
        }
    }

    public int query(int left, int right, int threshold) {
        for (Map.Entry<Integer, TreeMap<Integer, Integer>> entry : map.entrySet()) {
            int num = entry.getKey();
            TreeMap<Integer, Integer> positions = entry.getValue();
            Integer start = positions.floorKey(right);
            Integer end = positions.floorKey(left - 1);
            int count = start == null ? 0 : positions.get(start);
            if (end != null) {
                count -= positions.get(end);
            }
            if (count >= threshold) {
                return num;
            }
        }
        return -1;
    }
}