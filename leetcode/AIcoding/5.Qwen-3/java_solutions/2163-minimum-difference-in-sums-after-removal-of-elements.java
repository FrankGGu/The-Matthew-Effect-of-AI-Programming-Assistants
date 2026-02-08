public class Solution {

import java.util.*;

public class Solution {
    public long minimumDifference(int[] nums) {
        int n = nums.length;
        long[] left = new long[n];
        long[] right = new long[n];

        PriorityQueue<Integer> minHeap = new PriorityQueue<>();
        long sum = 0;
        for (int i = 0; i < n; i++) {
            if (minHeap.size() < n / 2) {
                minHeap.add(nums[i]);
                sum += nums[i];
            } else {
                if (nums[i] > minHeap.peek()) {
                    sum -= minHeap.poll();
                    sum += nums[i];
                    minHeap.add(nums[i]);
                }
            }
            left[i] = sum;
        }

        PriorityQueue<Integer> maxHeap = new PriorityQueue<>(Collections.reverseOrder());
        sum = 0;
        for (int i = n - 1; i >= 0; i--) {
            if (maxHeap.size() < n / 2) {
                maxHeap.add(nums[i]);
                sum += nums[i];
            } else {
                if (nums[i] > maxHeap.peek()) {
                    sum -= maxHeap.poll();
                    sum += nums[i];
                    maxHeap.add(nums[i]);
                }
            }
            right[i] = sum;
        }

        long minDiff = Long.MAX_VALUE;
        for (int i = n / 2 - 1; i < n - n / 2; i++) {
            long leftSum = left[i];
            long rightSum = right[i + 1];
            minDiff = Math.min(minDiff, Math.abs(leftSum - rightSum));
        }

        return minDiff;
    }
}
}