public class Solution {

import java.util.*;

public class Solution {
    public int[] rearrange(int[] nums, int k) {
        int n = nums.length;
        int[] result = new int[n];
        PriorityQueue<int[]> minHeap = new PriorityQueue<>(Comparator.comparingInt(a -> a[0]));
        for (int i = 0; i < n; i++) {
            minHeap.offer(new int[]{nums[i], i});
        }

        int[] used = new int[n];
        int[] indices = new int[n];
        int index = 0;

        while (!minHeap.isEmpty()) {
            int[] top = minHeap.poll();
            int val = top[0];
            int originalIndex = top[1];
            if (used[originalIndex] == 0) {
                indices[index++] = originalIndex;
                used[originalIndex] = 1;
            }
        }

        int[] sorted = new int[n];
        for (int i = 0; i < n; i++) {
            sorted[i] = nums[indices[i]];
        }

        Arrays.sort(sorted);

        int[] res = new int[n];
        int left = 0, right = n - 1;
        for (int i = 0; i < n; i++) {
            if (i % 2 == 0) {
                res[i] = sorted[left++];
            } else {
                res[i] = sorted[right--];
            }
        }

        int[] finalResult = new int[n];
        for (int i = 0; i < n; i++) {
            finalResult[indices[i]] = res[i];
        }

        return finalResult;
    }
}
}