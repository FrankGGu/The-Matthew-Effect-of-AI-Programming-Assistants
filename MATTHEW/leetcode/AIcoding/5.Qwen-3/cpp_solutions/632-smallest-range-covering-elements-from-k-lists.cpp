#include <iostream>
#include <vector>
#include <queue>
#include <climits>

using namespace std;

class Solution {
public:
    vector<int> smallestRange(vector<vector<int>>& lists) {
        int k = lists.size();
        vector<int> index(k, 0);
        priority_queue<pair<int, int>, vector<pair<int, int>>, greater<>> minHeap;

        for (int i = 0; i < k; ++i) {
            if (lists[i].size() > 0) {
                minHeap.push({lists[i][0], i});
            }
        }

        int currentMax = INT_MIN;
        vector<int> range = {0, INT_MAX};

        while (!minHeap.empty()) {
            auto [val, listIdx] = minHeap.top();
            minHeap.pop();

            if (val - currentMax < range[1] - range[0]) {
                range[0] = currentMax;
                range[1] = val;
            }

            if (index[listIdx] + 1 < lists[listIdx].size()) {
                index[listIdx]++;
                int nextVal = lists[listIdx][index[listIdx]];
                minHeap.push({nextVal, listIdx});
                currentMax = max(currentMax, nextVal);
            } else {
                break;
            }
        }

        return range;
    }
};