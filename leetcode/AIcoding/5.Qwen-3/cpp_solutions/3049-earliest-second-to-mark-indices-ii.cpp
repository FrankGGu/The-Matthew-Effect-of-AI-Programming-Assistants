#include <iostream>
#include <vector>
#include <unordered_map>
#include <queue>

using namespace std;

class Solution {
public:
    int earliestSecondToMarkIndices(vector<int>& nums) {
        int n = nums.size();
        vector<int> count(n, 0);
        unordered_map<int, queue<int>> pos;

        for (int i = 0; i < n; ++i) {
            pos[nums[i]].push(i);
        }

        int time = 0;
        int marked = 0;

        while (marked < n) {
            for (auto& [num, q] : pos) {
                if (!q.empty() && count[q.front()] == time) {
                    count[q.front()] = time + 1;
                    marked++;
                    q.pop();
                }
            }
            time++;
        }

        return time - 1;
    }
};