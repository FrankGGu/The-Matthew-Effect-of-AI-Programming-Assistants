#include <iostream>
#include <vector>

using namespace std;

class Solution {
public:
    int arrayNesting(vector<int>& nums) {
        int maxLen = 0;
        int n = nums.size();
        vector<bool> visited(n, false);

        for (int i = 0; i < n; ++i) {
            if (!visited[i]) {
                int start = i;
                int count = 0;
                while (!visited[start]) {
                    visited[start] = true;
                    start = nums[start];
                    ++count;
                }
                maxLen = max(maxLen, count);
            }
        }
        return maxLen;
    }
};