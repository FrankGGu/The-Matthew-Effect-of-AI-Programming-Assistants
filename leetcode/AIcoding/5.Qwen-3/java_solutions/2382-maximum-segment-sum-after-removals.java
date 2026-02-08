public class Solution {

import java.util.*;

public class Solution {
    public long[] maximumSegmentSum(int[] nums, int[] removeQueries) {
        int n = nums.length;
        long[] result = new long[n];
        Map<Integer, Integer> parent = new HashMap<>();
        Map<Integer, Long> sum = new HashMap<>();
        Set<Integer> removed = new HashSet<>();

        for (int i = 0; i < n; i++) {
            parent.put(i, i);
            sum.put(i, (long) nums[i]);
        }

        for (int i = n - 1; i >= 0; i--) {
            int pos = removeQueries[i];
            removed.add(pos);
            sum.put(pos, (long) nums[pos]);
            if (removed.contains(pos + 1)) {
                union(pos, pos + 1, parent, sum);
            }
            if (removed.contains(pos - 1)) {
                union(pos, pos - 1, parent, sum);
            }
            result[i] = getSum(pos, parent, sum);
        }

        return result;
    }

    private int find(int x, Map<Integer, Integer> parent) {
        if (parent.get(x) != x) {
            parent.put(x, find(parent.get(x), parent));
        }
        return parent.get(x);
    }

    private void union(int x, int y, Map<Integer, Integer> parent, Map<Integer, Long> sum) {
        int rootX = find(x, parent);
        int rootY = find(y, parent);
        if (rootX != rootY) {
            parent.put(rootY, rootX);
            sum.put(rootX, sum.get(rootX) + sum.get(rootY));
        }
    }

    private long getSum(int x, Map<Integer, Integer> parent, Map<Integer, Long> sum) {
        int root = find(x, parent);
        return sum.get(root);
    }
}
}