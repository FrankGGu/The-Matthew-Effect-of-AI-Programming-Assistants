class Solution {
public:
    long long numberOfWeeks(vector<int>& milestones) {
        long long sum = 0;
        int maxMilestone = 0;
        for (int milestone : milestones) {
            sum += milestone;
            maxMilestone = max(maxMilestone, milestone);
        }
        long long remaining = sum - maxMilestone;
        if (maxMilestone > remaining) {
            return 2 * remaining + 1;
        } else {
            return sum;
        }
    }
};