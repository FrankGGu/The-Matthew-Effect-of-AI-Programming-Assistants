#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    vector<int> sortJumbled(vector<int>& mapping, vector<int>& nums) {
        vector<pair<int, int>> mappedNums;
        for (int i = 0; i < nums.size(); ++i) {
            string s = to_string(nums[i]);
            string mappedString = "";
            for (char c : s) {
                mappedString += to_string(mapping[c - '0']);
            }
            mappedNums.push_back({stoi(mappedString), nums[i]});
        }

        sort(mappedNums.begin(), mappedNums.end());

        vector<int> result;
        for (auto& p : mappedNums) {
            result.push_back(p.second);
        }

        return result;
    }
};