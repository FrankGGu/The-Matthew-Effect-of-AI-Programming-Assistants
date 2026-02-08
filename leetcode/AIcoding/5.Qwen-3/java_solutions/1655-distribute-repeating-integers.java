public class Solution {

import java.util.*;

public class Solution {
    public boolean canDistribute(int[] nums) {
        Map<Integer, Integer> freq = new HashMap<>();
        for (int num : nums) {
            freq.put(num, freq.getOrDefault(num, 0) + 1);
        }

        List<Integer> counts = new ArrayList<>(freq.values());
        Collections.sort(counts, Collections.reverseOrder());

        int[] groups = new int[5];
        return backtrack(counts, 0, groups);
    }

    private boolean backtrack(List<Integer> counts, int index, int[] groups) {
        if (index == counts.size()) {
            return true;
        }

        int count = counts.get(index);
        for (int i = 0; i < 5; i++) {
            if (groups[i] + count <= 5 && (i == 0 || groups[i] != groups[i - 1])) {
                groups[i] += count;
                if (backtrack(counts, index + 1, groups)) {
                    return true;
                }
                groups[i] -= count;
            }
        }

        return false;
    }
}
}