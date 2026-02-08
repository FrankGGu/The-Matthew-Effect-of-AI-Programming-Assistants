import java.util.LinkedList;
import java.util.Queue;

class Solution {
    public int minimumOperations(int nums[], int start, int goal) {
        Queue<Integer> q = new LinkedList<>();
        q.offer(start);
        boolean[] visited = new boolean[1001];
        visited[start] = true;
        int steps = 0;

        while (!q.isEmpty()) {
            int size = q.size();
            for (int i = 0; i < size; i++) {
                int curr = q.poll();

                if (curr == goal) {
                    return steps;
                }

                for (int num : nums) {
                    int next1 = curr + num;
                    int next2 = curr - num;
                    int next3 = curr ^ num;

                    if (next1 >= 0 && next1 <= 1000 && !visited[next1]) {
                        q.offer(next1);
                        visited[next1] = true;
                    } else if (next1 == goal) return steps + 1;

                    if (next2 >= 0 && next2 <= 1000 && !visited[next2]) {
                        q.offer(next2);
                        visited[next2] = true;
                    } else if (next2 == goal) return steps + 1;

                    if (next3 >= 0 && next3 <= 1000 && !visited[next3]) {
                        q.offer(next3);
                        visited[next3] = true;
                    } else if (next3 == goal) return steps + 1;

                    if (next1 < 0 || next1 > 1000 && next1 == goal) return steps + 1;
                    if (next2 < 0 || next2 > 1000 && next2 == goal) return steps + 1;
                    if (next3 < 0 || next3 > 1000 && next3 == goal) return steps + 1;
                }
            }
            steps++;
        }

        return -1;
    }
}