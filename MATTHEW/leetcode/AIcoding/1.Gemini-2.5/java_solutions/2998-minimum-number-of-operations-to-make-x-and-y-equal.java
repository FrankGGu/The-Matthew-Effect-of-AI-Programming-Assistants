import java.util.LinkedList;
import java.util.Queue;

class Solution {
    public int minimumOperationsToMakeEqual(int x, int y) {
        if (x == y) {
            return 0;
        }

        Queue<int[]> q = new LinkedList<>();
        // Max value for x, y is 10^4. x+1 could go slightly above this to find a divisible number.
        // A size of 20001 covers numbers from 0 to 20000, which is sufficient.
        boolean[] visited = new boolean[20001]; 

        q.offer(new int[]{x, 0});
        visited[x] = true;

        while (!q.isEmpty()) {
            int[] current = q.poll();
            int currentNum = current[0];
            int steps = current[1];

            if (currentNum == y) {
                return steps;
            }

            // Operation 1: Decrement x by 1
            int nextNum = currentNum - 1;
            // Ensure nextNum is a positive integer (as per problem constraints for x, y)
            // and it hasn't been visited yet.
            if (nextNum >= 1 && !visited[nextNum]) {
                visited[nextNum] = true;
                q.offer(new int[]{nextNum, steps + 1});
            }

            // Operation 2: Increment x by 1
            nextNum = currentNum + 1;
            // Ensure nextNum is within the bounds of our visited array
            // and it hasn't been visited yet.
            if (nextNum < visited.length && !visited[nextNum]) {
                visited[nextNum] = true;
                q.offer(new int[]{nextNum, steps + 1});
            }

            // Operation 3: Divide x by 5
            if (currentNum % 5 == 0) {
                nextNum = currentNum / 5;
                // Ensure nextNum is a positive integer and not visited.
                // If currentNum % 5 == 0 and currentNum >= 1, then nextNum will be >= 1.
                if (!visited[nextNum]) {
                    visited[nextNum] = true;
                    q.offer(new int[]{nextNum, steps + 1});
                }
            }

            // Operation 4: Divide x by 11
            if (currentNum % 11 == 0) {
                nextNum = currentNum / 11;
                // Ensure nextNum is a positive integer and not visited.
                // If currentNum % 11 == 0 and currentNum >= 1, then nextNum will be >= 1.
                if (!visited[nextNum]) {
                    visited[nextNum] = true;
                    q.offer(new int[]{nextNum, steps + 1});
                }
            }
        }

        // This part should theoretically not be reached because y is always reachable from x
        // using the given operations (e.g., by repeatedly decrementing/incrementing).
        return -1; 
    }
}