import java.util.LinkedList;
import java.util.Queue;

class Solution {
    public boolean canReach(int[] arr, int start) {
        int n = arr.length;
        boolean[] visited = new boolean[n];
        Queue<Integer> q = new LinkedList<>();

        q.offer(start);
        visited[start] = true;

        while (!q.isEmpty()) {
            int curr = q.poll();

            if (arr[curr] == 0) {
                return true;
            }

            // Check left jump
            int leftJump = curr - arr[curr];
            if (leftJump >= 0 && !visited[leftJump]) {
                q.offer(leftJump);
                visited[leftJump] = true;
            }

            // Check right jump
            int rightJump = curr + arr[curr];
            if (rightJump < n && !visited[rightJump]) {
                q.offer(rightJump);
                visited[rightJump] = true;
            }
        }

        return false;
    }
}