public class Solution {

import java.util.*;

public class Solution {
    public int beautifulSubsets(int[] nums, int k) {
        Map<Integer, Integer> count = new HashMap<>();
        for (int num : nums) {
            count.put(num, count.getOrDefault(num, 0) + 1);
        }

        List<Integer> keys = new ArrayList<>(count.keySet());
        Collections.sort(keys);

        int[] result = {0};

        backtrack(keys, 0, k, count, result);

        return result[0];
    }

    private void backtrack(List<Integer> keys, int index, int k, Map<Integer, Integer> count, int[] result) {
        if (index == keys.size()) {
            result[0]++;
            return;
        }

        int num = keys.get(index);
        int prev = num - k;

        if (!count.containsKey(prev)) {
            backtrack(keys, index + 1, k, count, result);
        }

        int freq = count.get(num);
        count.put(num, freq - 1);
        if (freq - 1 > 0) {
            backtrack(keys, index + 1, k, count, result);
        }
        count.put(num, freq);

        if (!count.containsKey(num - k)) {
            backtrack(keys, index + 1, k, count, result);
        }
    }
}
}