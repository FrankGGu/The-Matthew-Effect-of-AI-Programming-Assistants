#include <iostream>
#include <vector>
#include <unordered_map>
#include <algorithm>

using namespace std;

class Solution {
public:
    int minOperationsToMakeTheArrayAlternating(vector<int>& nums) {
        if (nums.size() == 1) return 0;

        unordered_map<int, int> freq;
        for (int num : nums) {
            freq[num]++;
        }

        vector<pair<int, int>> sortedFreq(freq.begin(), freq.end());
        sort(sortedFreq.begin(), sortedFreq.end(), [](const pair<int, int>& a, const pair<int, int>& b) {
            return a.second > b.second;
        });

        int first = sortedFreq[0].first;
        int second = sortedFreq[1].first;

        int countFirst = 0;
        int countSecond = 0;

        for (int i = 0; i < nums.size(); i++) {
            if (i % 2 == 0) {
                if (nums[i] != first) countFirst++;
                if (nums[i] != second) countSecond++;
            } else {
                if (nums[i] != first) countSecond++;
                if (nums[i] != second) countFirst++;
            }
        }

        return min(countFirst, countSecond);
    }
};