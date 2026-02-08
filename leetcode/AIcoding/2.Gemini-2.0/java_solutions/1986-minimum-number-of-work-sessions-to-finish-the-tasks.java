class Solution {
    public int minSessions(int[] tasks, int sessionTime) {
        int n = tasks.length;
        int ans = n;
        for (int mask = 0; mask < (1 << n); mask++) {
            int count = Integer.bitCount(mask);
            if (count >= ans) continue;

            int sessions = 1;
            int currentTime = 0;
            boolean valid = true;
            int[] tasksInSession = new int[n];
            int taskIndex = 0;

            for (int i = 0; i < n; i++) {
                if ((mask & (1 << i)) != 0) {
                    tasksInSession[taskIndex++] = tasks[i];
                }
            }

            currentTime = tasksInSession[0];
            for (int i = 1; i < taskIndex; i++) {
                if (currentTime + tasksInSession[i] <= sessionTime) {
                    currentTime += tasksInSession[i];
                } else {
                    sessions++;
                    currentTime = tasksInSession[i];
                }
            }

            if (sessions > 1) {

            }

            if (sessions <= ans) {

                boolean[] assigned = new boolean[n];

                int numSessions = 0;
                int currentSessionTime = 0;

                for(int i = 0; i < n; i++){
                    assigned[i] = false;
                }

                int remainingTasks = count;

                while(remainingTasks > 0){
                    numSessions++;
                    currentSessionTime = 0;

                    for(int i = 0; i < n; i++){
                        if((mask & (1 << i)) != 0 && !assigned[i]){
                            if(currentSessionTime + tasks[i] <= sessionTime){
                                currentSessionTime += tasks[i];
                                assigned[i] = true;
                                remainingTasks--;
                            }
                        }
                    }
                }

                if(numSessions <= ans){
                    ans = numSessions;
                }

            }

        }
        return ans;
    }
}