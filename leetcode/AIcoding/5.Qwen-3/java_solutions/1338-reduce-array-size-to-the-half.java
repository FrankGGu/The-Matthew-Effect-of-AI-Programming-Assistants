public class Solution {

import java.util.*;

public class Solution {
    public int minSetSize(int[] arr) {
        Map<Integer, Integer> frequency = new HashMap<>();
        for (int num : arr) {
            frequency.put(num, frequency.getOrDefault(num, 0) + 1);
        }

        List<Map.Entry<Integer, Integer>> list = new ArrayList<>(frequency.entrySet());
        list.sort((a, b) -> b.getValue() - a.getValue());

        int count = 0;
        int size = 0;
        for (Map.Entry<Integer, Integer> entry : list) {
            count += entry.getValue();
            size++;
            if (count >= arr.length / 2) {
                return size;
            }
        }

        return size;
    }
}
}