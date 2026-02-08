import java.util.PriorityQueue;

class Solution {
    public int findCrossingTime(int n, int k, int[][] time) {
        PriorityQueue<int[]> leftBank = new PriorityQueue<>((a, b) -> {
            if (a[1] != b[1]) {
                return b[1] - a[1];
            } else {
                return b[0] - a[0];
            }
        });
        PriorityQueue<int[]> rightBank = new PriorityQueue<>((a, b) -> {
            if (a[1] != b[1]) {
                return b[1] - a[1];
            } else {
                return b[0] - a[0];
            }
        });
        PriorityQueue<int[]> leftWorking = new PriorityQueue<>((a, b) -> a[2] - b[2]);
        PriorityQueue<int[]> rightWorking = new PriorityQueue<>((a, b) -> a[2] - b[2]);

        for (int i = 0; i < k; i++) {
            leftBank.offer(new int[]{i, time[i][0] + time[i][2], 0});
        }

        int currentTime = 0;
        int remainingBoxes = n;

        while (remainingBoxes > 0 || !rightBank.isEmpty() || !rightWorking.isEmpty()) {
            while (!leftWorking.isEmpty() && leftWorking.peek()[2] <= currentTime) {
                int[] worker = leftWorking.poll();
                leftBank.offer(new int[]{worker[0], time[worker[0]][0] + time[worker[0]][2], 0});
            }
            while (!rightWorking.isEmpty() && rightWorking.peek()[2] <= currentTime) {
                int[] worker = rightWorking.poll();
                rightBank.offer(new int[]{worker[0], time[worker[0]][0] + time[worker[0]][2], 0});
            }

            if (!rightBank.isEmpty()) {
                int[] worker = rightBank.poll();
                currentTime += time[worker[0]][2];
                leftWorking.offer(new int[]{worker[0], 0, currentTime + time[worker[0]][3]});
            } else if (remainingBoxes > 0 && !leftBank.isEmpty()) {
                int[] worker = leftBank.poll();
                currentTime += time[worker[0]][0];
                rightWorking.offer(new int[]{worker[0], 0, currentTime + time[worker[0]][1]});
                remainingBoxes--;
            } else {
                int nextEvent = Integer.MAX_VALUE;
                if (!leftWorking.isEmpty()) {
                    nextEvent = Math.min(nextEvent, leftWorking.peek()[2]);
                }
                if (!rightWorking.isEmpty()) {
                    nextEvent = Math.min(nextEvent, rightWorking.peek()[2]);
                }
                if (nextEvent != Integer.MAX_VALUE) {
                    currentTime = nextEvent;
                }
            }
        }

        return currentTime;
    }
}