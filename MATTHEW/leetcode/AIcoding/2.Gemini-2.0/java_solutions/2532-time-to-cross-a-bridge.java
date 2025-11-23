import java.util.PriorityQueue;

class Solution {
    public int timeToCross(int n, int k, int[][] time) {
        PriorityQueue<int[]> leftWait = new PriorityQueue<>((a, b) -> (time[b[0]][0] + time[b[0]][1]) - (time[a[0]][0] + time[a[0]][1]));
        PriorityQueue<int[]> rightWait = new PriorityQueue<>((a, b) -> (time[b[0]][0] + time[b[0]][1]) - (time[a[0]][0] + time[a[0]][1]));
        PriorityQueue<int[]> leftWork = new PriorityQueue<>((a, b) -> a[1] - b[1]);
        PriorityQueue<int[]> rightWork = new PriorityQueue<>((a, b) -> a[1] - b[1]);

        for (int i = 0; i < n; i++) {
            leftWait.offer(new int[]{i, 0});
        }

        int currentTime = 0;
        int crossed = 0;

        while (crossed < n) {
            while (!leftWork.isEmpty() && leftWork.peek()[1] <= currentTime) {
                rightWait.offer(new int[]{leftWork.poll()[0], 0});
            }

            while (!rightWork.isEmpty() && rightWork.peek()[1] <= currentTime) {
                leftWait.offer(new int[]{rightWork.poll()[0], 0});
            }

            if (!rightWait.isEmpty()) {
                if (!leftWait.isEmpty() || !leftWork.isEmpty() || !rightWork.isEmpty()) {
                    int[] worker = rightWait.poll();
                    currentTime += time[worker[0]][2];
                    rightWork.offer(new int[]{worker[0], currentTime + time[worker[0]][3]});
                    crossed++;
                } else {
                    currentTime = Math.min(leftWork.isEmpty() ? Integer.MAX_VALUE : leftWork.peek()[1],
                            rightWork.isEmpty() ? Integer.MAX_VALUE : rightWork.peek()[1]);
                }
            } else if (!leftWait.isEmpty()) {
                if (!leftWork.isEmpty() || !rightWork.isEmpty()) {
                    int[] worker = leftWait.poll();
                    currentTime += time[worker[0]][0];
                    leftWork.offer(new int[]{worker[0], currentTime + time[worker[0]][1]});
                } else {
                     currentTime = Math.min(leftWork.isEmpty() ? Integer.MAX_VALUE : leftWork.peek()[1],
                            rightWork.isEmpty() ? Integer.MAX_VALUE : rightWork.peek()[1]);
                }

            } else {
                currentTime = Math.min(leftWork.isEmpty() ? Integer.MAX_VALUE : leftWork.peek()[1],
                        rightWork.isEmpty() ? Integer.MAX_VALUE : rightWork.peek()[1]);
            }

        }

        return currentTime;
    }
}