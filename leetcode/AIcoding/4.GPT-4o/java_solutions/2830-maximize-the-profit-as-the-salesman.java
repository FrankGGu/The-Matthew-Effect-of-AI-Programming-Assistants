class Solution {
    public int maximizeProfit(int[] profit, int[] capital, int w) {
        int n = profit.length;
        int[][] projects = new int[n][2];
        for (int i = 0; i < n; i++) {
            projects[i][0] = capital[i];
            projects[i][1] = profit[i];
        }
        Arrays.sort(projects, (a, b) -> Integer.compare(a[0], b[0]));

        PriorityQueue<Integer> maxHeap = new PriorityQueue<>((a, b) -> b - a);
        int idx = 0;

        for (int i = 0; i < w; i++) {
            while (idx < n && projects[idx][0] <= i) {
                maxHeap.offer(projects[idx][1]);
                idx++;
            }
            if (!maxHeap.isEmpty()) {
                i += maxHeap.poll();
            }
        }

        return i;
    }
}