public class Solution {

import java.util.Arrays;
import java.util.PriorityQueue;

public class Solution {
    public int minOperations(int[] nums1, int[] nums2) {
        int sum1 = 0, sum2 = 0;
        for (int num : nums1) sum1 += num;
        for (int num : nums2) sum2 += num;

        if (sum1 == sum2) return 0;

        if (sum1 > sum2) {
            int[] temp = nums1;
            nums1 = nums2;
            nums2 = temp;
        }

        PriorityQueue<Integer> maxHeap = new PriorityQueue<>((a, b) -> b - a);

        for (int num : nums1) {
            maxHeap.add(6 - num);
        }

        for (int num : nums2) {
            maxHeap.add(num - 1);
        }

        int operations = 0;
        int diff = Math.abs(sum1 - sum2);

        while (diff > 0 && !maxHeap.isEmpty()) {
            diff -= maxHeap.poll();
            operations++;
        }

        return diff == 0 ? operations : -1;
    }
}
}