#include <vector>
#include <algorithm>
#include <queue>

using namespace std;

class Solution {
public:
    vector<long long> maxMinKSum(vector<int>& nums, int k) {
        vector<long long> result(2, 0);
        int n = nums.size();

        // For maximum sum: select the largest k elements
        vector<int> maxNums(nums);
        sort(maxNums.begin(), maxNums.end(), greater<int>());
        for (int i = 0; i < k; ++i) {
            result[0] += maxNums[i];
        }

        // For minimum sum: select the smallest k elements
        vector<int> minNums(nums);
        sort(minNums.begin(), minNums.end());
        for (int i = 0; i < k; ++i) {
            result[1] += minNums[i];
        }

        return result;
    }
};