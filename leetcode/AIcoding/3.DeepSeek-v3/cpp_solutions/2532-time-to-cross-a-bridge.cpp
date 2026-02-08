#include <vector>
#include <queue>
#include <algorithm>

using namespace std;

class Solution {
public:
    int findCrossingTime(int n, int k, vector<vector<int>>& time) {
        auto cmp_left = [&](int a, int b) {
            int time_a = time[a][0] + time[a][2];
            int time_b = time[b][0] + time[b][2];
            if (time_a != time_b) return time_a < time_b;
            return a < b;
        };
        auto cmp_right = [&](int a, int b) {
            int time_a = time[a][0] + time[a][2];
            int time_b = time[b][0] + time[b][2];
            if (time_a != time_b) return time_a < time_b;
            return a < b;
        };
        priority_queue<int, vector<int>, decltype(cmp_left)> left_waiting(cmp_left);
        priority_queue<int, vector<int>, decltype(cmp_right)> right_waiting(cmp_right);
        priority_queue<pair<int, int>, vector<pair<int, int>>, greater<pair<int, int>>> left_working, right_working;

        for (int i = 0; i < k; ++i) {
            left_waiting.push(i);
        }

        int current_time = 0;
        int boxes_left = n;
        while (boxes_left > 0 || !right_waiting.empty() || !right_working.empty()) {
            while (!left_working.empty() && left_working.top().first <= current_time) {
                int worker = left_working.top().second;
                left_working.pop();
                left_waiting.push(worker);
            }
            while (!right_working.empty() && right_working.top().first <= current_time) {
                int worker = right_working.top().second;
                right_working.pop();
                right_waiting.push(worker);
            }

            if (!right_waiting.empty()) {
                int worker = right_waiting.top();
                right_waiting.pop();
                current_time += time[worker][2];
                left_working.push({current_time + time[worker][3], worker});
            } else if (boxes_left > 0 && !left_waiting.empty()) {
                int worker = left_waiting.top();
                left_waiting.pop();
                current_time += time[worker][0];
                right_working.push({current_time + time[worker][1], worker});
                boxes_left--;
            } else {
                int next_time = INT_MAX;
                if (!left_working.empty()) next_time = min(next_time, left_working.top().first);
                if (!right_working.empty()) next_time = min(next_time, right_working.top().first);
                if (next_time != INT_MAX) current_time = max(current_time, next_time);
            }
        }
        return current_time;
    }
};