public class Solution {

import java.util.*;

public class Solution {
    public List<Integer> recoverTheOriginalArray(int[] target, int arrLen) {
        int n = target.length;
        Map<Integer, Integer> freq = new HashMap<>();
        for (int num : target) {
            freq.put(num, freq.getOrDefault(num, 0) + 1);
        }

        List<Integer> result = new ArrayList<>();
        Arrays.sort(target);

        for (int i = 0; i < n; i++) {
            if (freq.get(target[i]) == 0) continue;
            int current = target[i];
            int count = 1;
            freq.put(current, freq.get(current) - 1);
            int j = i + 1;
            while (j < n && count < arrLen) {
                if (freq.get(target[j]) > 0 && target[j] - current == target[j - 1] - target[i]) {
                    freq.put(target[j], freq.get(target[j]) - 1);
                    count++;
                    j++;
                } else {
                    break;
                }
            }
            if (count == arrLen) {
                for (int k = i; k < i + arrLen; k++) {
                    result.add(target[k]);
                }
                return result;
            }
        }

        return result;
    }
}
}