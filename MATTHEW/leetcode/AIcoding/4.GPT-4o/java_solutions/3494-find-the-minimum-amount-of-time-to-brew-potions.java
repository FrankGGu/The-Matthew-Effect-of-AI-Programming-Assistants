class Solution {
    public long minTimeToBrew(int[] time, int[] cost, int target) {
        int n = time.length;
        long left = 1, right = 1_000_000_000_000L;
        long answer = -1;

        while (left <= right) {
            long mid = left + (right - left) / 2;
            if (canBrew(time, cost, mid, target)) {
                answer = mid;
                right = mid - 1;
            } else {
                left = mid + 1;
            }
        }

        return answer;
    }

    private boolean canBrew(int[] time, int[] cost, long totalTime, int target) {
        long totalPotions = 0;
        for (int i = 0; i < time.length; i++) {
            totalPotions += totalTime / time[i];
            if (totalPotions >= target) {
                return true;
            }
        }
        return totalPotions >= target;
    }
}