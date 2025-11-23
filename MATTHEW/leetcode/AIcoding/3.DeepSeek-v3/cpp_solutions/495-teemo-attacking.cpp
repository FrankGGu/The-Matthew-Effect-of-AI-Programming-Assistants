class Solution {
public:
    int findPoisonedDuration(vector<int>& timeSeries, int duration) {
        if (timeSeries.empty()) return 0;
        int total = 0;
        for (int i = 0; i < timeSeries.size() - 1; ++i) {
            total += min(timeSeries[i + 1] - timeSeries[i], duration);
        }
        return total + duration;
    }
};