#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int minCost(string colors, vector<int>& neededTime) {
        int n = colors.size();
        int ans = 0;
        int i = 0;
        while (i < n - 1) {
            if (colors[i] == colors[i + 1]) {
                int j = i;
                int max_time = 0;
                int total_time = 0;
                while (j < n && colors[i] == colors[j]) {
                    max_time = max(max_time, neededTime[j]);
                    total_time += neededTime[j];
                    j++;
                }
                ans += total_time - max_time;
                i = j;
            } else {
                i++;
            }
        }
        return ans;
    }
};