import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

class Solution {
    public long numberOfPairs(int[] nums1, int[] nums2, int diff) {
        int n = nums1.length;
        int[] diffs = new int[n];
        for (int i = 0; i < n; i++) {
            diffs[i] = nums1[i] - nums2[i];
        }

        long count = 0;
        List<Integer> sortedList = new ArrayList<>();
        for (int i = 0; i < n; i++) {
            int target = diffs[i] + diff;
            int index = binarySearch(sortedList, target);
            count += sortedList.size() - index;

            int insertIndex = Collections.binarySearch(sortedList, diffs[i]);
            if (insertIndex < 0) {
                insertIndex = -insertIndex - 1;
            }
            sortedList.add(insertIndex, diffs[i]);
        }

        return count;
    }

    private int binarySearch(List<Integer> list, int target) {
        int left = 0;
        int right = list.size();
        while (left < right) {
            int mid = left + (right - left) / 2;
            if (list.get(mid) > target) {
                right = mid;
            } else {
                left = mid + 1;
            }
        }
        return left;
    }
}