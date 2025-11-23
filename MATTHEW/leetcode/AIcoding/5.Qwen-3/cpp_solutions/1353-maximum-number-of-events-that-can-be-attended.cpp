#include <iostream>
#include <vector>
#include <queue>
#include <algorithm>

using namespace std;

class Solution {
public:
    int maxEvents(vector<vector<int>>& events) {
        sort(events.begin(), events.end());
        int n = events.size();
        int res = 0;
        int i = 0;
        priority_queue<int, vector<int>, greater<int>> pq;
        while (i < n || !pq.empty()) {
            if (pq.empty()) {
                pq.push(events[i][1]);
                i++;
            } else {
                if (i < n && events[i][0] <= pq.top()) {
                    pq.push(events[i][1]);
                    i++;
                } else {
                    pq.pop();
                    res++;
                }
            }
        }
        return res;
    }
};