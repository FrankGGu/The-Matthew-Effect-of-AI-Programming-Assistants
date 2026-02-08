import java.util.PriorityQueue;
import java.util.Comparator;

class Solution {
    public long findCrossingTime(int n, int k, int[][] time) {
        long curTime = 0L;
        long ans = 0L; // Stores the time when the last worker crosses L->R

        // Priority queue for workers waiting on the left bank (to cross L->R)
        // Stores [workerId]
        // Order: largest crossing time (L->R) first, then largest workerId
        PriorityQueue<int[]> leftBank = new PriorityQueue<>(
            (a, b) -> {
                int idA = a[0];
                int idB = b[0];
                int timeA = time[idA][0];
                int timeB = time[idB][0];
                if (timeA != timeB) {
                    return timeB - timeA; // Descending order for crossing time
                }
                return idB - idA; // Descending order for workerId
            }
        );

        // Priority queue for workers waiting on the right bank (to cross R->L)
        // Stores [workerId]
        // Order: largest crossing time (R->L) first, then largest workerId
        PriorityQueue<int[]> rightBank = new PriorityQueue<>(
            (a, b) -> {
                int idA = a[0];
                int idB = b[0];
                int timeA = time[idA][1];
                int timeB = time[idB][1];
                if (timeA != timeB) {
                    return timeB - timeA; // Descending order for crossing time
                }
                return idB - idA; // Descending order for workerId
            }
        );

        // Priority queue for workers currently crossing from left to right
        // Stores [finishTime, workerId]
        // Order: earliest finishTime first
        PriorityQueue<long[]> leftToRightCrossing = new PriorityQueue<>(
            Comparator.comparingLong(a -> a[0])
        );

        // Priority queue for workers currently crossing from right to left
        // Stores [finishTime, workerId]
        // Order: earliest finishTime first
        PriorityQueue<long[]> rightToLeftCrossing = new PriorityQueue<>(
            Comparator.comparingLong(a -> a[0])
        );

        // Initially, all n workers are on the left bank
        for (int i = 0; i < n; i++) {
            leftBank.offer(new int[]{i});
        }

        int workersFinishedRight = 0; // Count of workers who have crossed L->R

        while (workersFinishedRight < n) {
            // 1. Check for workers arriving from the bridge at or before curTime
            // Workers arriving from R->L go to leftBank
            while (!rightToLeftCrossing.isEmpty() && rightToLeftCrossing.peek()[0] <= curTime) {
                long[] worker = rightToLeftCrossing.poll();
                leftBank.offer(new int[]{(int)worker[1]});
            }
            // Workers arriving from L->R go to rightBank
            while (!leftToRightCrossing.isEmpty() && leftToRightCrossing.peek()[0] <= curTime) {
                long[] worker = leftToRightCrossing.poll();
                rightBank.offer(new int[]{(int)worker[1]});
                workersFinishedRight++;
                ans = Math.max(ans, worker[0]); // Update the latest finish time for a worker crossing L->R
            }

            // If all workers have crossed L->R, we are done
            if (workersFinishedRight == n) {
                break;
            }

            // 2. Decide who crosses next, if bridge capacity allows
            boolean sentWorker = false;
            if (leftToRightCrossing.size() + rightToLeftCrossing.size() < k) {
                // Prioritize right bank to left crossing
                if (!rightBank.isEmpty()) {
                    int[] worker = rightBank.poll();
                    rightToLeftCrossing.offer(new long[]{curTime + time[worker[0]][1], worker[0]});
                    sentWorker = true;
                }
                // If right bank is empty, try left bank to right crossing
                else if (!leftBank.isEmpty()) {
                    int[] worker = leftBank.poll();
                    leftToRightCrossing.offer(new long[]{curTime + time[worker[0]][0], worker[0]});
                    sentWorker = true;
                }
            }

            // 3. Advance time if no worker was sent
            if (!sentWorker) {
                // If no worker could be sent, it means either:
                // a) Bridge is full.
                // b) Bridge is not full, but both leftBank and rightBank are empty.
                // In either case, we must wait for the earliest worker on the bridge to finish.
                long nextFinishTime = Long.MAX_VALUE;
                if (!leftToRightCrossing.isEmpty()) {
                    nextFinishTime = Math.min(nextFinishTime, leftToRightCrossing.peek()[0]);
                }
                if (!rightToLeftCrossing.isEmpty()) {
                    nextFinishTime = Math.min(nextFinishTime, rightToLeftCrossing.peek()[0]);
                }
                curTime = nextFinishTime;
            }
        }

        return ans;
    }
}