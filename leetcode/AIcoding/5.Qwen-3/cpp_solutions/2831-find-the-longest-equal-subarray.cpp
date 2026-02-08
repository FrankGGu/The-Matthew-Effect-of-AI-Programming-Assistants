#include <iostream>
#include <vector>
#include <unordered_map>

using namespace std;

class Solution {
public:
    int longestEqualSubarray(int k, vector<int>& nums) {
        unordered_map<int, vector<int>> pos;
        for (int i = 0; i < nums.size(); ++i) {
            pos[nums[i]].push_back(i);
        }

        int maxLen = 0;
        for (auto& [num, indices] : pos) {
            for (int i = 0; i < indices.size(); ++i) {
                int j = i;
                while (j + 1 < indices.size() && indices[j + 1] - indices[i] <= k) {
                    ++j;
                }
                maxLen = max(maxLen, j - i + 1);
            }
        }
        return maxLen;
    }
};