#include <iostream>
#include <vector>
#include <unordered_map>

using namespace std;

class Solution {
public:
    int sumOfSquares(int n, vector<int>& nums) {
        int result = 0;
        unordered_map<int, int> lastOccurrence;
        for (int i = 0; i < n; ++i) {
            if (lastOccurrence.find(nums[i]) != lastOccurrence.end()) {
                int prev = lastOccurrence[nums[i]];
                result += (i - prev) * (i - prev);
            }
            lastOccurrence[nums[i]] = i;
        }
        return result;
    }
};