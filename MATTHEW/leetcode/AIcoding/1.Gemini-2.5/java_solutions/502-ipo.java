import java.util.Arrays;
import java.util.PriorityQueue;
import java.util.Collections;

class Solution {
    private static class Project {
        int capital;
        int profit;

        Project(int capital, int profit) {
            this.capital = capital;
            this.profit = profit;
        }
    }

    public int findMaximizedCapital(int k, int w, int[] profits, int[] capital) {
        int n = profits.length;
        Project[] projects = new Project[n];

        for (int i = 0; i < n; i++) {
            projects[i] = new Project(capital[i], profits[i]);
        }

        Arrays.sort(projects, (a, b) -> a.capital - b.capital);

        PriorityQueue<Integer> maxProfitHeap = new PriorityQueue<>(Collections.reverseOrder());
        int projectIndex = 0;

        for (int i = 0; i < k; i++) {
            while (projectIndex < n && projects[projectIndex].capital <= w) {
                maxProfitHeap.offer(projects[projectIndex].profit);
                projectIndex++;
            }

            if (maxProfitHeap.isEmpty()) {
                break;
            }

            w += maxProfitHeap.poll();
        }

        return w;
    }
}