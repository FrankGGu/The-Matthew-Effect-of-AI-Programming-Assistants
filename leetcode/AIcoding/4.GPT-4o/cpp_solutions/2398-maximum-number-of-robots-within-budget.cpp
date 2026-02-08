class Solution {
public:
    int maximumRobots(vector<int>& chargeTimes, int budget) {
        int n = chargeTimes.size();
        int left = 0, right = 0, maxRobots = 0;
        multiset<int> window;
        long long totalCost = 0;

        while (right < n) {
            totalCost += chargeTimes[right];
            window.insert(chargeTimes[right]);

            while (totalCost + (long long)(window.size() - 1) * *window.rbegin() > budget) {
                totalCost -= chargeTimes[left];
                window.erase(window.find(chargeTimes[left]));
                left++;
            }

            maxRobots = max(maxRobots, right - left + 1);
            right++;
        }

        return maxRobots;
    }
};