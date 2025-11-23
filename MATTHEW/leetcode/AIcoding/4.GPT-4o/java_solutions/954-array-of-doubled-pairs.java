import java.util.Arrays;
import java.util.HashMap;
import java.util.Map;

class Solution {
    public boolean canReorderDoubled(int[] arr) {
        Map<Integer, Integer> count = new HashMap<>();
        for (int num : arr) {
            count.put(num, count.getOrDefault(num, 0) + 1);
        }

        Integer[] keys = count.keySet().toArray(new Integer[0]);
        Arrays.sort(keys, (a, b) -> Math.abs(a) - Math.abs(b));

        for (int key : keys) {
            if (count.get(key) > count.getOrDefault(key * 2, 0)) {
                return false;
            }
            count.put(key * 2, count.getOrDefault(key * 2, 0) - count.get(key));
        }

        return true;
    }
}