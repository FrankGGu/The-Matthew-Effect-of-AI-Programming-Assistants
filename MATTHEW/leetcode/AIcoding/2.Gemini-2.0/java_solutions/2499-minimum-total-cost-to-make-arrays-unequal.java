import java.util.Arrays;
import java.util.PriorityQueue;

class Solution {
    public long minimumTotalCost(int[] nums1, int[] nums2) {
        int n = nums1.length;
        int[] count = new int[100001];
        int same = 0;
        long cost = 0;
        int maxCount = 0;
        int maxVal = 0;

        for (int i = 0; i < n; i++) {
            if (nums1[i] == nums2[i]) {
                count[nums1[i]]++;
                same++;
                cost += i;
                if (count[nums1[i]] > maxCount) {
                    maxCount = count[nums1[i]];
                    maxVal = nums1[i];
                }
            }
        }

        if (maxCount <= same - maxCount) {
            return cost;
        }

        PriorityQueue<Integer> pq = new PriorityQueue<>();
        for (int i = 0; i < n; i++) {
            if (nums1[i] != nums2[i] && nums1[i] != maxVal && nums2[i] != maxVal) {
                pq.offer(i);
            }
        }

        int need = maxCount - (same - maxCount);
        if (pq.size() < need) {
            return -1;
        }

        while (need > 0) {
            cost += pq.poll();
            need--;
        }

        return cost;
    }
}