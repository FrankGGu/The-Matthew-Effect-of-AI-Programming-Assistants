class Solution {
public:
    long long minCost(vector<int>& nums, vector<int>& cost) {
        vector<pair<int, int>> elements;
        for (int i = 0; i < nums.size(); ++i) {
            elements.emplace_back(nums[i], cost[i]);
        }
        sort(elements.begin(), elements.end());

        long long totalCost = 0;
        for (auto& [num, c] : elements) {
            totalCost += c;
        }

        long long medianCost = 0;
        long long currentCost = 0;
        int median = 0;
        for (auto& [num, c] : elements) {
            currentCost += c;
            if (currentCost > totalCost / 2) {
                median = num;
                break;
            }
        }

        long long result = 0;
        for (auto& [num, c] : elements) {
            result += (long long)abs(num - median) * c;
        }

        return result;
    }
};