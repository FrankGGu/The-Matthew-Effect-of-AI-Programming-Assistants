#include <iostream>
#include <vector>
#include <queue>
#include <algorithm>

using namespace std;

class Solution {
public:
    int findCrossingTime(int n, int k, vector<vector<int>>& time) {
        vector<int> left;
        vector<int> right;
        for (int i = 0; i < k; ++i) {
            left.push_back(i);
        }
        sort(left.begin(), left.end(), [&](int a, int b) { return time[a][0] < time[b][0]; });
        sort(right.begin(), right.end(), [&](int a, int b) { return time[a][0] < time[b][0]; });

        priority_queue<pair<int, int>, vector<pair<int, int>>, greater<>> waitLeft;
        priority_queue<pair<int, int>, vector<pair<int, int>>, greater<>> waitRight;

        int timeElapsed = 0;
        while (n > 0 || !waitLeft.empty() || !waitRight.empty()) {
            while (!left.empty() && time[left.back()][0] <= timeElapsed) {
                waitLeft.push({time[left.back()][1], left.back()});
                left.pop_back();
            }

            while (!right.empty() && time[right.back()][0] <= timeElapsed) {
                waitRight.push({time[right.back()][1], right.back()});
                right.pop_back();
            }

            if (!waitLeft.empty()) {
                auto [t, id] = waitLeft.top();
                waitLeft.pop();
                timeElapsed += t;
                right.push(id);
                continue;
            }

            if (!waitRight.empty()) {
                auto [t, id] = waitRight.top();
                waitRight.pop();
                timeElapsed += t;
                left.push(id);
                continue;
            }

            int nextTime = INT_MAX;
            if (!left.empty()) {
                nextTime = time[left.back()][0];
            }
            if (!right.empty()) {
                nextTime = min(nextTime, time[right.back()][0]);
            }
            if (nextTime == INT_MAX) {
                break;
            }
            timeElapsed = nextTime;
        }
        return timeElapsed;
    }
};