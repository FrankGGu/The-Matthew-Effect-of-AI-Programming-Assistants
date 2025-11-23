#include <iostream>
#include <vector>
#include <queue>
#include <algorithm>

using namespace std;

class Solution {
public:
    int kthSmallestChair(vector<vector<int>>& times, int k) {
        int n = times.size();
        vector<pair<int, int>> events(n);
        for (int i = 0; i < n; ++i) {
            events[i] = {times[i][0], i};
        }
        sort(events.begin(), events.end());

        priority_queue<int, vector<int>, greater<int>> available;
        for (int i = 0; i < n; ++i) {
            available.push(i);
        }

        vector<int> seat(n);
        int time = 0;
        for (int i = 0; i < n; ++i) {
            time = events[i].first;
            int person = events[i].second;
            while (!available.empty() && seat[available.top()] <= time) {
                available.pop();
            }
            if (available.empty()) {
                return -1;
            }
            seat[available.top()] = time + times[person][1];
            if (i == k - 1) {
                return available.top();
            }
            available.pop();
        }
        return -1;
    }
};