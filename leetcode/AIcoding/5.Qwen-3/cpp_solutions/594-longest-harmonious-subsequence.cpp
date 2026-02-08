#include <iostream>
#include <vector>
#include <map>

using namespace std;

class Solution {
public:
    int findLongestSubsequence(vector<int>& nums) {
        map<int, int> count;
        for (int num : nums) {
            count[num]++;
        }

        int maxLength = 0;
        for (auto it = count.begin(); it != count.end(); ++it) {
            if (count.find(it->first + 1) != count.end()) {
                maxLength = max(maxLength, it->second + count[it->first + 1]);
            }
        }

        return maxLength;
    }
};