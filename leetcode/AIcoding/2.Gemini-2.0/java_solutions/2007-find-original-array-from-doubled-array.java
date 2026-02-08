import java.util.Arrays;
import java.util.HashMap;
import java.util.Map;

class Solution {
    public int[] findOriginalArray(int[] changed) {
        if (changed.length % 2 != 0) {
            return new int[0];
        }

        int n = changed.length / 2;
        int[] original = new int[n];
        Map<Integer, Integer> count = new HashMap<>();

        for (int num : changed) {
            count.put(num, count.getOrDefault(num, 0) + 1);
        }

        Arrays.sort(changed);

        int index = 0;
        for (int num : changed) {
            if (count.get(num) == 0) {
                continue;
            }

            count.put(num, count.get(num) - 1);
            int doubled = num * 2;

            if (count.containsKey(doubled) && count.get(doubled) > 0) {
                original[index++] = num;
                count.put(doubled, count.get(doubled) - 1);
            } else {
                return new int[0];
            }
        }

        return original;
    }
}