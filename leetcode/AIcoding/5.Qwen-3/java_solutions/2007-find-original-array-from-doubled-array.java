public class Solution {

import java.util.*;

public class Solution {
    public int[] originalArray(int[] changed) {
        if (changed.length % 2 != 0) {
            return new int[0];
        }

        Map<Integer, Integer> count = new HashMap<>();
        for (int num : changed) {
            count.put(num, count.getOrDefault(num, 0) + 1);
        }

        List<Integer> original = new ArrayList<>();
        List<Integer> sorted = new ArrayList<>(count.keySet());
        Collections.sort(sorted);

        for (int num : sorted) {
            if (count.get(num) == 0) {
                continue;
            }
            if (num == 0) {
                if (count.get(num) % 2 != 0) {
                    return new int[0];
                }
                for (int i = 0; i < count.get(num) / 2; i++) {
                    original.add(num);
                }
                count.put(num, 0);
            } else {
                int twice = num * 2;
                if (!count.containsKey(twice) || count.get(twice) < count.get(num)) {
                    return new int[0];
                }
                for (int i = 0; i < count.get(num); i++) {
                    original.add(num);
                }
                count.put(twice, count.get(twice) - count.get(num));
                count.put(num, 0);
            }
        }

        if (original.size() != changed.length / 2) {
            return new int[0];
        }

        int[] result = new int[original.size()];
        for (int i = 0; i < result.length; i++) {
            result[i] = original.get(i);
        }
        return result;
    }
}
}