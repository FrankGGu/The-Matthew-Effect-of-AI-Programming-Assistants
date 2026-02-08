class Solution {
    public long maxWeeks(int[] milestones) {
        long totalMilestones = 0;
        for (int m : milestones) {
            totalMilestones += m;
        }
        int maxMilestone = 0;
        for (int m : milestones) {
            maxMilestone = Math.max(maxMilestone, m);
        }
        long weeks = totalMilestones - maxMilestone;
        return Math.min(weeks + maxMilestone + 1, totalMilestones);
    }
}