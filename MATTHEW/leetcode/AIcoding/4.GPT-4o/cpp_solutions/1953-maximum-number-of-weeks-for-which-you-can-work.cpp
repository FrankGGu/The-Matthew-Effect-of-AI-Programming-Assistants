class Solution {
public:
    long long maxWeeks(vector<int>& milestones) {
        long long total = accumulate(milestones.begin(), milestones.end(), 0LL);
        long long maxMilestone = *max_element(milestones.begin(), milestones.end());
        long long weeks = min(total, 2 * (total - maxMilestone) + 1);
        return weeks;
    }
};