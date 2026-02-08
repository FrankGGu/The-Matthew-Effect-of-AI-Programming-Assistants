import java.util.Arrays;
import java.util.PriorityQueue;

class Solution {
    public int[] advantageCount(int[] A, int[] B) {
        int n = A.length;
        Arrays.sort(A);
        Integer[] B_indices = new Integer[n];
        for (int i = 0; i < n; i++) {
            B_indices[i] = i;
        }
        Arrays.sort(B_indices, (i, j) -> B[j] - B[i]);

        int[] result = new int[n];
        PriorityQueue<Integer> pq = new PriorityQueue<>();
        for (int a : A) {
            pq.offer(a);
        }

        for (int index : B_indices) {
            if (pq.peek() > B[index]) {
                result[index] = pq.poll();
            } else {
                result[index] = pq.poll();
                pq.offer(result[index]);
            }
        }

        return result;
    }
}