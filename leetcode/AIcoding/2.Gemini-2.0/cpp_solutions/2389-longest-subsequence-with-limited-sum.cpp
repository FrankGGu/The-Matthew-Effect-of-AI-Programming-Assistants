#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    vector<int> answerQueries(vector<int>& nums, vector<int>& queries) {
        sort(nums.begin(), nums.end());
        vector<int> ans;
        for (int q : queries) {
            int count = 0;
            int sum = 0;
            for (int i = 0; i < nums.size(); ++i) {
                if (sum + nums[i] <= q) {
                    sum += nums[i];
                    count++;
                } else {
                    break;
                }
            }
            ans.push_back(count);
        }
        return ans;
    }
};