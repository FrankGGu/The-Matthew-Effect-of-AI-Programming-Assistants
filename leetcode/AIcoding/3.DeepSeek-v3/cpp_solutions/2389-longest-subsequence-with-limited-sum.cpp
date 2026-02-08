#include <vector>
#include <algorithm>
using namespace std;

class Solution {
public:
    vector<int> answerQueries(vector<int>& nums, vector<int>& queries) {
        sort(nums.begin(), nums.end());
        vector<int> prefix(nums.size());
        prefix[0] = nums[0];
        for (int i = 1; i < nums.size(); i++) {
            prefix[i] = prefix[i-1] + nums[i];
        }

        vector<int> ans;
        for (int q : queries) {
            auto it = upper_bound(prefix.begin(), prefix.end(), q);
            ans.push_back(it - prefix.begin());
        }
        return ans;
    }
};