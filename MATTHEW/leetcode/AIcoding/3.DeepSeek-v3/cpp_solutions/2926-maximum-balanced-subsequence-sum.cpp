#include <vector>
#include <set>
#include <algorithm>

using namespace std;

class Solution {
public:
    long long maxBalancedSubsequenceSum(vector<int>& nums) {
        int n = nums.size();
        vector<pair<int, long long>> elements;
        for (int i = 0; i < n; ++i) {
            elements.emplace_back(nums[i] - i, nums[i]);
        }

        sort(elements.begin(), elements.end());

        set<pair<int, long long>> s;
        long long maxSum = LLONG_MIN;
        for (const auto& [key, val] : elements) {
            long long current = val;
            auto it = s.lower_bound({key, LLONG_MIN});
            if (it != s.begin()) {
                --it;
                current += it->second;
            }
            maxSum = max(maxSum, current);

            auto insertPos = s.lower_bound({key, current});
            while (insertPos != s.end() && insertPos->second <= current) {
                s.erase(insertPos);
                insertPos = s.lower_bound({key, current});
            }
            if (insertPos == s.end() || insertPos->first != key) {
                s.insert({key, current});
            }
        }

        return maxSum;
    }
};