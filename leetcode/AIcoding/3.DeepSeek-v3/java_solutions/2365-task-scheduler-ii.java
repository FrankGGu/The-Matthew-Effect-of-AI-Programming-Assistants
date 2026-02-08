class Solution {
    public long taskSchedulerII(int[] tasks, int space) {
        Map<Integer, Long> lastDay = new HashMap<>();
        long currentDay = 0;

        for (int task : tasks) {
            currentDay++;
            if (lastDay.containsKey(task)) {
                long last = lastDay.get(task);
                if (currentDay - last <= space) {
                    currentDay = last + space + 1;
                }
            }
            lastDay.put(task, currentDay);
        }

        return currentDay;
    }
}