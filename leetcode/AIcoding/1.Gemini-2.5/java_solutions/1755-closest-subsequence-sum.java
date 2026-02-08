import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

class Solution {
    private List<Integer> generateSums(int[] nums, int start, int end) {
        List<Integer> sums = new ArrayList<>();
        sums.add(0); // Represents the empty subsequence sum

        for (int i = start; i < end; i++) {
            int currentNum = nums[i];
            int currentSize = sums.size();
            for (int j = 0; j < currentSize; j++) {
                sums.add(sums.get(j) + currentNum);
            }
        }
        return sums;
    }

    public int minAbsDifference(int[] nums, int goal) {
        int n = nums.length;
        int mid = n / 2;

        List<Integer> sums1 = generateSums(nums, 0, mid);
        List<Integer> sums2 = generateSums(nums, mid, n);

        Collections.sort(sums2);

        long minDiff = Long.MAX_VALUE;

        for (int s1 : sums1) {
            long target2 = goal - s1;

            int idx = Collections.binarySearch(sums2, (int) target2);

            if (idx >= 0) {
                return 0; // Found an exact match, difference is 0
            } else {
                int insertionPoint = -idx - 1;

                // Check the element at insertionPoint (first element greater than target2)
                if (insertionPoint < sums2.size()) {
                    minDiff = Math.min(minDiff, Math.abs(goal - (s1 + sums2.get(insertionPoint))));
                }

                // Check the element before insertionPoint (last element less than or equal to target2)
                if (insertionPoint > 0) {
                    minDiff = Math.min(minDiff, Math.abs(goal - (s1 + sums2.get(insertionPoint - 1))));
                }
            }
        }

        return (int) minDiff;
    }
}