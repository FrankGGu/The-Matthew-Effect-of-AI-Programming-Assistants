#include <vector>

using namespace std;

class Solution {
public:
    vector<int> lastVisitedIntegers(vector<string>& words) {
        vector<int> nums;
        vector<int> ans;
        int k = 0;

        for (string& word : words) {
            if (word == "prev") {
                k++;
                if (nums.size() < k) {
                    ans.push_back(-1);
                } else {
                    ans.push_back(nums[nums.size() - k]);
                }
            } else {
                nums.push_back(stoi(word));
                k = 0;
            }
        }

        return ans;
    }
};