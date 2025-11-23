class Solution {
public:
    vector<bool> canEat(vector<int>& candiesCount, vector<vector<int>>& queries) {
        int n = candiesCount.size();
        vector<long long> prefix(n + 1, 0);
        for (int i = 0; i < n; ++i) {
            prefix[i + 1] = prefix[i] + candiesCount[i];
        }

        vector<bool> result;
        for (const auto& query : queries) {
            int favoriteType = query[0];
            int favoriteDay = query[1];
            int dailyCap = query[2];

            long long minCandies = favoriteDay + 1;
            long long maxCandies = (favoriteDay + 1) * dailyCap;

            long long totalCandies = prefix[favoriteType + 1];
            long long candiesBefore = prefix[favoriteType];

            if (minCandies > totalCandies - candiesBefore || maxCandies <= candiesBefore) {
                result.push_back(false);
            } else {
                result.push_back(true);
            }
        }

        return result;
    }
};