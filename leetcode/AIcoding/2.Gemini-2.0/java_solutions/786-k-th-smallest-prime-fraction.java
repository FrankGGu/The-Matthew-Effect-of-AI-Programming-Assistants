import java.util.PriorityQueue;

class Solution {
    public int[] kthSmallestPrimeFraction(int[] arr, int k) {
        PriorityQueue<int[]> pq = new PriorityQueue<>((a, b) -> arr[a[0]] * arr[b[1]] - arr[b[0]] * arr[a[1]]);
        for (int i = 0; i < arr.length; i++) {
            pq.offer(new int[]{0, i});
        }

        for (int i = 1; i < k; i++) {
            int[] top = pq.poll();
            if (top[0] + 1 < arr.length) {
                pq.offer(new int[]{top[0] + 1, top[1]});
            }
        }

        int[] top = pq.poll();
        return new int[]{arr[top[0]], arr[top[1]]};
    }
}