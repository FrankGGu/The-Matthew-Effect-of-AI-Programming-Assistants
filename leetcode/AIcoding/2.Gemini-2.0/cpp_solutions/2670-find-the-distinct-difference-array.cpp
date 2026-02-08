#include <vector>
#include <unordered_set>

using namespace std;

class Solution {
public:
    vector<int> distinctDifferenceArray(vector<int>& nums) {
        int n = nums.size();
        vector<int> result(n);
        for (int i = 0; i < n; ++i) {
            unordered_set<int> prefix_distinct;
            unordered_set<int> suffix_distinct;

            for (int j = 0; j <= i; ++j) {
                prefix_distinct.insert(nums[j]);
            }

            for (int j = i + 1; j < n; ++j) {
                suffix_distinct.insert(nums[j]);
            }

            result[i] = prefix_distinct.size() - suffix_distinct.size();
        }
        return result;
    }
};