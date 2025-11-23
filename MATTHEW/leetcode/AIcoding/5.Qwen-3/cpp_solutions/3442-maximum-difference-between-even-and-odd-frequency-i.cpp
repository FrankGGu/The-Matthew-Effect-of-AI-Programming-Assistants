#include <iostream>
#include <vector>
#include <unordered_map>

using namespace std;

class Solution {
public:
    int maxEvenOddDifference(vector<int>& nums) {
        unordered_map<int, int> freq;
        for (int num : nums) {
            freq[num]++;
        }

        int maxDiff = 0;
        for (auto& [num, count] : freq) {
            if (count % 2 == 0) {
                for (auto& [otherNum, otherCount] : freq) {
                    if (otherCount % 2 == 1) {
                        maxDiff = max(maxDiff, count - otherCount);
                    }
                }
            }
        }

        return maxDiff;
    }
};