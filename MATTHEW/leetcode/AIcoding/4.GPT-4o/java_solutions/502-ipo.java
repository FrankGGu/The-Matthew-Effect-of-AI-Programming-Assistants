import java.util.PriorityQueue;

public class Solution {
    public int findMaximizedCapital(int k, int W, int[] Profits, int[] Capital) {
        int n = Profits.length;
        int[][] projects = new int[n][2];
        for (int i = 0; i < n; i++) {
            projects[i][0] = Capital[i];
            projects[i][1] = Profits[i];
        }

        Arrays.sort(projects, (a, b) -> Integer.compare(a[0], b[0]));

        PriorityQueue<Integer> maxHeap = new PriorityQueue<>((a, b) -> b - a);
        int i = 0;

        for (int j = 0; j < k; j++) {
            while (i < n && projects[i][0] <= W) {
                maxHeap.offer(projects[i][1]);
                i++;
            }
            if (!maxHeap.isEmpty()) {
                W += maxHeap.poll();
            }
        }

        return W;
    }
}