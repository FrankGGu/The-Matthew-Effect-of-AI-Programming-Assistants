public class Solution {

import java.util.*;

public class Solution {
    public int minOperations(int[] target, int[] nums) {
        Map<Integer, Integer> indexMap = new HashMap<>();
        for (int i = 0; i < target.length; i++) {
            indexMap.put(target[i], i);
        }

        List<Integer> subsequence = new ArrayList<>();
        for (int num : nums) {
            if (indexMap.containsKey(num)) {
                int idx = indexMap.get(num);
                int left = 0, right = subsequence.size() - 1;
                while (left <= right) {
                    int mid = left + (right - left) / 2;
                    if (subsequence.get(mid) < idx) {
                        left = mid + 1;
                    } else {
                        right = mid - 1;
                    }
                }
                if (left == subsequence.size()) {
                    subsequence.add(idx);
                } else {
                    subsequence.set(left, idx);
                }
            }
        }

        return target.length - subsequence.size();
    }
}
}