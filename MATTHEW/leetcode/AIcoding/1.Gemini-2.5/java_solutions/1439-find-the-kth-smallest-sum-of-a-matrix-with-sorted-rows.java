import java.util.ArrayList;
import java.util.Collections;
import java.util.HashSet;
import java.util.List;
import java.util.PriorityQueue;
import java.util.Set;

class Solution {
    public int kthSmallest(int[][] mat, int k) {
        // Initialize currentSums with the elements of the first row.
        // These are effectively the "sums" after considering the first row.
        List<Integer> currentSums = new ArrayList<>();
        for (int x : mat[0]) {
            currentSums.add(x);
        }

        // Iterate through the remaining rows, combining currentSums with each row.
        for (int r = 1; r < mat.length; r++) {
            // PriorityQueue to find the K smallest sums when combining currentSums and mat[r].
            // Each element in PQ is an array: {sum, index_in_currentSums, index_in_mat_r}
            PriorityQueue<int[]> pq = new PriorityQueue<>((a, b) -> a[0] - b[0]);

            // Set to keep track of visited (index_in_currentSums, index_in_mat_r) pairs
            Set<String> visited = new HashSet<>();

            // Initial state: combine the first element of currentSums with the first element of mat[r].
            // This is the starting point for finding the K smallest pair sums.
            // currentSums will never be empty after the first row.
            pq.offer(new int[]{currentSums.get(0) + mat[r][0], 0, 0});
            visited.add("0,0");

            List<Integer> nextSums = new ArrayList<>();
            int count = 0;

            // Extract K smallest sums from the priority queue
            while (!pq.isEmpty() && count < k) {
                int[] state = pq.poll();
                int sum = state[0];
                int idx1 = state[1]; // Index in currentSums
                int idx2 = state[2]; // Index in mat[r]

                nextSums.add(sum);
                count++;

                // Option 1: Move to the next element in mat[r] (increment idx2)
                // This generates a new sum using the same element from currentSums but the next from mat[r].
                if (idx2 + 1 < mat[r].length) {
                    String newKey = idx1 + "," + (idx2 + 1);
                    if (!visited.contains(newKey)) {
                        pq.offer(new int[]{currentSums.get(idx1) + mat[r][idx2 + 1], idx1, idx2 + 1});
                        visited.add(newKey);
                    }
                }

                // Option 2: Move to the next element in currentSums (increment idx1)
                // This generates a new sum using the same element from mat[r] but the next from currentSums.
                if (idx1 + 1 < currentSums.size()) {
                    String newKey = (idx1 + 1) + "," + idx2;
                    if (!visited.contains(newKey)) {
                        pq.offer(new int[]{currentSums.get(idx1 + 1) + mat[r][idx2], idx1 + 1, idx2});
                        visited.add(newKey);
                    }
                }
            }
            // Update currentSums for the next iteration.
            // nextSums now contains the K smallest sums (or fewer if total sums < K)
            // formed by combining the previous currentSums with mat[r].
            currentSums = nextSums;
        }

        // After iterating through all rows, currentSums will contain the K smallest sums
        // (or all possible sums if fewer than K exist) in sorted order.
        // The Kth smallest sum is at index K-1.
        return currentSums.get(k - 1);
    }
}