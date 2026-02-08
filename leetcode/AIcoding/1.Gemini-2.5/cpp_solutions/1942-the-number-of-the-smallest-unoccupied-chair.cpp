#include <vector>
#include <queue>
#include <algorithm>
#include <array>

class Solution {
public:
    int smallestChair(std::vector<std::vector<int>>& times, int targetFriend) {
        int n = times.size();

        std::vector<std::array<int, 3>> indexed_times;
        indexed_times.reserve(n);
        for (int i = 0; i < n; ++i) {
            indexed_times.push_back({times[i][0], times[i][1], i});
        }

        std::sort(indexed_times.begin(), indexed_times.end());

        std::priority_queue<int, std::vector<int>, std::greater<int>> available_chairs;
        std::priority_queue<std::pair<int, int>, std::vector<std::pair<int, int>>, std::greater<std::pair<int, int>>> occupied_chairs;

        int next_chair = 0;

        for (const auto& friend_event : indexed_times) {
            int arrival = friend_event[0];
            int leaving = friend_event[1];
            int index = friend_event[2];

            while (!occupied_chairs.empty() && occupied_chairs.top().first <= arrival) {
                available_chairs.push(occupied_chairs.top().second);
                occupied_chairs.pop();
            }

            int assigned_chair;
            if (!available_chairs.empty()) {
                assigned_chair = available_chairs.top();
                available_chairs.pop();
            } else {
                assigned_chair = next_chair;
                next_chair++;
            }

            if (index == targetFriend) {
                return assigned_chair;
            }

            occupied_chairs.push({leaving, assigned_chair});
        }

        return -1;
    }
};