import java.util.*;

class Solution {
    public int[] smallestTrimmedNumbers(String[] nums, int[][] queries) {
        int n = queries.length;
        int[] result = new int[n];

        for (int i = 0; i < n; i++) {
            int k = queries[i][0];
            int trim = queries[i][1];
            List<Pair> list = new ArrayList<>();

            for (int j = 0; j < nums.length; j++) {
                String trimmed = nums[j].substring(nums[j].length() - trim);
                list.add(new Pair(trimmed, j));
            }

            Collections.sort(list, (a, b) -> {
                if (a.num.equals(b.num)) {
                    return Integer.compare(a.index, b.index);
                }
                return a.num.compareTo(b.num);
            });

            result[i] = list.get(k - 1).index;
        }

        return result;
    }

    private class Pair {
        String num;
        int index;

        Pair(String num, int index) {
            this.num = num;
            this.index = index;
        }
    }
}