#include <vector>

using namespace std;

class Solution {
public:
    vector<bool> canEat(vector<int>& candiesCount, vector<vector<int>>& queries) {
        int n = candiesCount.size();
        vector<long long> prefixSum(n);
        prefixSum[0] = candiesCount[0];
        for (int i = 1; i < n; ++i) {
            prefixSum[i] = prefixSum[i - 1] + candiesCount[i];
        }

        vector<bool> result;
        for (auto& query : queries) {
            int type = query[0];
            int day = query[1];
            int cap = query[2];

            long long minEat = (long long)day + 1;
            long long maxEat = (long long)(day + 1) * cap;

            long long candiesBefore = (type == 0) ? 0 : prefixSum[type - 1];
            long long candiesAvailable = prefixSum[type];

            if (minEat > candiesAvailable) {
                result.push_back(false);
            } else if (maxEat <= candiesBefore) {
                result.push_back(false);
            } else {
                result.push_back(true);
            }
        }

        return result;
    }
};