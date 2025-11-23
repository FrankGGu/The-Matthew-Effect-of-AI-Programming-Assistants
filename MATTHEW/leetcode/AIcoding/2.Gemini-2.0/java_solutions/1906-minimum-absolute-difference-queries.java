import java.util.ArrayList;
import java.util.List;

class Solution {
    public List<Integer> minDifference(int[] nums, int[][] queries) {
        int n = nums.length;
        List<Integer> result = new ArrayList<>();
        for (int[] query : queries) {
            int left = query[0];
            int right = query[1];
            List<Integer> subList = new ArrayList<>();
            for (int i = left; i <= right; i++) {
                subList.add(nums[i]);
            }
            if (subList.size() < 2) {
                result.add(-1);
                continue;
            }
            int minDiff = Integer.MAX_VALUE;
            List<Integer> sortedList = new ArrayList<>(subList);
            sortedList.sort(Integer::compareTo);
            for (int i = 0; i < sortedList.size() - 1; i++) {
                int diff = sortedList.get(i + 1) - sortedList.get(i);
                if (diff < minDiff) {
                    minDiff = diff;
                }
            }
            if (minDiff == Integer.MAX_VALUE) {
                result.add(-1);
            } else {
                result.add(minDiff);
            }
        }
        return result;
    }
}