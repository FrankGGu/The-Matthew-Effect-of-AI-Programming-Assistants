#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int arrayNesting(vector<int>& nums) {
        int n = nums.size();
        vector<bool> visited(n, false);
        int maxLength = 0;

        for (int i = 0; i < n; ++i) {
            if (!visited[i]) {
                int currentLength = 0;
                int current = i;
                while (!visited[current]) {
                    visited[current] = true;
                    current = nums[current];
                    currentLength++;
                }
                maxLength = max(maxLength, currentLength);
            }
        }

        return maxLength;
    }
};