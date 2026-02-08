#include <iostream>
#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int findLongestChain(vector<vector<int>>& pairs) {
        sort(pairs.begin(), pairs.end(), [](const vector<int>& a, const vector<int>& b) {
            return a[1] < b[1];
        });

        int count = 0;
        int lastEnd = INT_MIN;

        for (const auto& pair : pairs) {
            if (pair[0] > lastEnd) {
                count++;
                lastEnd = pair[1];
            }
        }

        return count;
    }
};