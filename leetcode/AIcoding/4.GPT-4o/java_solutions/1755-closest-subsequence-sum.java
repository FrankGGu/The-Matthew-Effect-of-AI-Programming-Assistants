import java.util.*;

class Solution {
    public int minAbsDifference(int[] nums, int goal) {
        int n = nums.length;
        Set<Integer> firstHalfSums = new HashSet<>();
        Set<Integer> secondHalfSums = new HashSet<>();

        for (int mask = 0; mask < (1 << (n / 2)); mask++) {
            int sum = 0;
            for (int i = 0; i < n / 2; i++) {
                if ((mask & (1 << i)) != 0) {
                    sum += nums[i];
                }
            }
            firstHalfSums.add(sum);
        }

        for (int mask = 0; mask < (1 << (n - n / 2)); mask++) {
            int sum = 0;
            for (int i = 0; i < (n - n / 2); i++) {
                if ((mask & (1 << i)) != 0) {
                    sum += nums[i + n / 2];
                }
            }
            secondHalfSums.add(sum);
        }

        List<Integer> secondHalfList = new ArrayList<>(secondHalfSums);
        Collections.sort(secondHalfList);

        int minDiff = Integer.MAX_VALUE;

        for (int sum1 : firstHalfSums) {
            int target = goal - sum1;
            int idx = binarySearch(secondHalfList, target);
            if (idx < secondHalfList.size()) {
                minDiff = Math.min(minDiff, Math.abs(sum1 + secondHalfList.get(idx) - goal));
            }
            if (idx > 0) {
                minDiff = Math.min(minDiff, Math.abs(sum1 + secondHalfList.get(idx - 1) - goal));
            }
        }

        return minDiff;
    }

    private int binarySearch(List<Integer> list, int target) {
        int left = 0, right = list.size();
        while (left < right) {
            int mid = left + (right - left) / 2;
            if (list.get(mid) <= target) {
                left = mid + 1;
            } else {
                right = mid;
            }
        }
        return left;
    }
}