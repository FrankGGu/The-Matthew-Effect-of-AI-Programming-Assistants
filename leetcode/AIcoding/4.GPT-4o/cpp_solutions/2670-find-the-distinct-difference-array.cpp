#include <vector>
#include <unordered_set>

using namespace std;

class Solution {
public:
    vector<int> findDistinctDifferenceArray(vector<int>& nums) {
        int n = nums.size();
        vector<int> result(n);
        unordered_set<int> leftSet, rightSet;

        for (int num : nums) {
            rightSet.insert(num);
        }

        for (int i = 0; i < n; ++i) {
            leftSet.insert(nums[i]);
            rightSet.erase(nums[i]);
            result[i] = leftSet.size() - rightSet.size();
        }

        return result;
    }
};