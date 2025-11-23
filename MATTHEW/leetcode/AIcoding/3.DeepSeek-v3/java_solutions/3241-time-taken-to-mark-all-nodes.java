class Solution {
    public int timeTaken(int[] arrival, int[] state) {
        Queue<int[]> enterQueue = new LinkedList<>();
        Queue<int[]> exitQueue = new LinkedList<>();
        int n = arrival.length;
        int currentTime = 0;
        int prevState = -1; // -1: no previous, 0: enter, 1: exit
        int[] res = new int[n];

        for (int i = 0; i < n; i++) {
            if (state[i] == 0) {
                enterQueue.offer(new int[]{arrival[i], i});
            } else {
                exitQueue.offer(new int[]{arrival[i], i});
            }
        }

        while (!enterQueue.isEmpty() || !exitQueue.isEmpty()) {
            int currentEnterTime = enterQueue.isEmpty() ? Integer.MAX_VALUE : enterQueue.peek()[0];
            int currentExitTime = exitQueue.isEmpty() ? Integer.MAX_VALUE : exitQueue.peek()[0];
            int minTime = Math.min(currentEnterTime, currentExitTime);

            if (currentTime < minTime) {
                currentTime = minTime;
                prevState = -1;
            }

            boolean exitFirst = false;
            boolean enterFirst = false;

            if (!exitQueue.isEmpty() && exitQueue.peek()[0] <= currentTime && (prevState == -1 || prevState == 1)) {
                exitFirst = true;
            }
            if (!enterQueue.isEmpty() && enterQueue.peek()[0] <= currentTime && (prevState == -1 || prevState == 0)) {
                enterFirst = true;
            }

            if (exitFirst) {
                int[] node = exitQueue.poll();
                res[node[1]] = currentTime;
                currentTime++;
                prevState = 1;
            } else if (enterFirst) {
                int[] node = enterQueue.poll();
                res[node[1]] = currentTime;
                currentTime++;
                prevState = 0;
            } else {
                if (!exitQueue.isEmpty() && exitQueue.peek()[0] <= currentTime) {
                    int[] node = exitQueue.poll();
                    res[node[1]] = currentTime;
                    currentTime++;
                    prevState = 1;
                } else if (!enterQueue.isEmpty() && enterQueue.peek()[0] <= currentTime) {
                    int[] node = enterQueue.poll();
                    res[node[1]] = currentTime;
                    currentTime++;
                    prevState = 0;
                }
            }
        }

        return res[n - 1];
    }
}