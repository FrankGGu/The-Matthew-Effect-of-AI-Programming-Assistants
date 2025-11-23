class Solution {
public:
    long long maximumRobots(vector<int>& chargeTimes, vector<int>& runningCosts, long long budget) {
        int n = chargeTimes.size();
        int left = 0;
        int right = 0;
        long long currentCost = 0;
        int maxLength = 0;
        multiset<int> charges;

        while (right < n) {
            charges.insert(chargeTimes[right]);
            currentCost += runningCosts[right];

            while (!charges.empty() && (long long)(*charges.rbegin() + currentCost * (right - left + 1)) > budget) {
                currentCost -= runningCosts[left];
                charges.erase(charges.find(chargeTimes[left]));
                left++;
            }

            maxLength = max(maxLength, right - left + 1);
            right++;
        }

        return maxLength;
    }
};