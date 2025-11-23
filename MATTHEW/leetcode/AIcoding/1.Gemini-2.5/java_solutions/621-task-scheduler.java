class Solution {
    public int leastInterval(char[] tasks, int n) {
        int[] freq = new int[26];
        for (char task : tasks) {
            freq[task - 'A']++;
        }

        int maxFreq = 0;
        for (int f : freq) {
            maxFreq = Math.max(maxFreq, f);
        }

        int countOfMaxFreq = 0;
        for (int f : freq) {
            if (f == maxFreq) {
                countOfMaxFreq++;
            }
        }

        // The minimum time required based on the most frequent task and cooldown.
        // (maxFreq - 1) represents the number of full cycles of (n+1) slots.
        // Each cycle has one instance of the most frequent task and 'n' cooldown slots.
        // The last cycle will contain 'countOfMaxFreq' tasks (all tasks with maxFreq)
        // without needing additional cooldown slots after them.
        int minTimeBasedOnFreq = (maxFreq - 1) * (n + 1) + countOfMaxFreq;

        // The total time must also be at least the total number of tasks,
        // as each task takes one unit of time.
        // This handles cases like n=0 or when there are enough diverse tasks
        // to fill all cooldown slots, making idle time unnecessary.
        return Math.max(tasks.length, minTimeBasedOnFreq);
    }
}