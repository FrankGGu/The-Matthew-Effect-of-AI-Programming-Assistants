#include <iostream>
#include <vector>
#include <unordered_map>

using namespace std;

class Solution {
public:
    int findMaxLength(vector<int>& nums) {
        unordered_map<int, int> map;
        map[0] = -1;
        int maxLength = 0;
        int count = 0;

        for (int i = 0; i < nums.size(); ++i) {
            count += (nums[i] == 1 ? 1 : -1);
            if (map.find(count) != map.end()) {
                maxLength = max(maxLength, i - map[count]);
            } else {
                map[count] = i;
            }
        }

        return maxLength;
    }
};