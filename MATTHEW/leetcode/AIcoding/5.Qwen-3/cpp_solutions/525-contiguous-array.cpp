#include <iostream>
#include <vector>
#include <unordered_map>

using namespace std;

class Solution {
public:
    int findMaxLength(vector<int>& nums) {
        unordered_map<int, int> sumIndex;
        sumIndex[0] = -1;
        int maxLength = 0;
        int currentSum = 0;

        for (int i = 0; i < nums.size(); ++i) {
            currentSum += (nums[i] == 0 ? -1 : 1);
            if (sumIndex.find(currentSum) != sumIndex.end()) {
                maxLength = max(maxLength, i - sumIndex[currentSum]);
            } else {
                sumIndex[currentSum] = i;
            }
        }

        return maxLength;
    }
};