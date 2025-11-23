public class Solution {

import java.util.*;

public class Solution {
    public int longestCommonSubpath(int n, int[][] paths) {
        if (n == 0 || paths.length == 0) return 0;

        List<List<Integer>> allPaths = new ArrayList<>();
        for (int[] path : paths) {
            List<Integer> list = new ArrayList<>();
            for (int num : path) {
                list.add(num);
            }
            allPaths.add(list);
        }

        int low = 0;
        int high = Integer.MAX_VALUE;
        for (List<Integer> path : allPaths) {
            high = Math.min(high, path.size());
        }

        int result = 0;
        while (low <= high) {
            int mid = (low + high) / 2;
            if (hasCommonSubpath(allPaths, mid)) {
                result = mid;
                low = mid + 1;
            } else {
                high = mid - 1;
            }
        }

        return result;
    }

    private boolean hasCommonSubpath(List<List<Integer>> allPaths, int length) {
        if (length == 0) return true;

        Set<String> commonSet = null;

        for (List<Integer> path : allPaths) {
            Set<String> currentSet = new HashSet<>();
            for (int i = 0; i <= path.size() - length; i++) {
                StringBuilder sb = new StringBuilder();
                for (int j = 0; j < length; j++) {
                    sb.append(path.get(i + j)).append(",");
                }
                currentSet.add(sb.toString());
            }

            if (commonSet == null) {
                commonSet = currentSet;
            } else {
                commonSet.retainAll(currentSet);
                if (commonSet.isEmpty()) {
                    return false;
                }
            }
        }

        return !commonSet.isEmpty();
    }
}
}