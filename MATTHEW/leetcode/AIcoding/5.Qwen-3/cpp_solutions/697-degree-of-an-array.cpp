#include <iostream>
#include <vector>
#include <unordered_map>
#include <climits>

using namespace std;

class Solution {
public:
    int findShortestSubArray(vector<int>& nums) {
        unordered_map<int, int> count;
        unordered_map<int, int> firstOccurrence;
        unordered_map<int, int> lastOccurrence;

        for (int i = 0; i < nums.size(); ++i) {
            if (count.find(nums[i]) == count.end()) {
                count[nums[i]] = 1;
                firstOccurrence[nums[i]] = i;
            } else {
                count[nums[i]]++;
            }
            lastOccurrence[nums[i]] = i;
        }

        int maxCount = 0;
        for (auto& pair : count) {
            if (pair.second > maxCount) {
                maxCount = pair.second;
            }
        }

        int minLength = INT_MAX;
        for (auto& pair : count) {
            if (pair.second == maxCount) {
                int length = lastOccurrence[pair.first] - firstOccurrence[pair.first] + 1;
                if (length < minLength) {
                    minLength = length;
                }
            }
        }

        return minLength;
    }
};