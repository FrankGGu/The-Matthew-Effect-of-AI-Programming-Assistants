#include <vector>
#include <queue>
#include <algorithm>
#include <utility>

class Solution {
public:
    int mostBooked(int n, std::vector<std::vector<int>>& meetings) {
        std::sort(meetings.begin(), meetings.end());

        std::vector<long long> meeting_counts(n, 0);

        std::priority_queue<int, std::vector<int>, std::greater<int>> available_rooms;
        for (int i = 0; i < n; ++i) {
            available_rooms.push(i);
        }

        std::priority_queue<std::pair<long long, int>, std::vector<std::pair<long long, int>>, std::greater<std::pair<long long, int>>> busy_rooms;

        for (const auto& meeting : meetings) {
            long long start = meeting[0];
            long long end = meeting[1];

            while (!busy_rooms.empty() && busy_rooms.top().first <= start) {
                int room_idx = busy_rooms.top().second;
                busy_rooms.pop();
                available_rooms.push(room_idx);
            }

            if (!available_rooms.empty()) {
                int room_idx = available_rooms.top();
                available_rooms.pop();

                busy_rooms.push({end, room_idx});
                meeting_counts[room_idx]++;
            } else {
                std::pair<long long, int> earliest_free = busy_rooms.top();
                busy_rooms.pop();

                long long new_end_time = earliest_free.first + (end - start);
                int room_idx = earliest_free.second;

                busy_rooms.push({new_end_time, room_idx});
                meeting_counts[room_idx]++;
            }
        }

        auto max_it = std::max_element(meeting_counts.begin(), meeting_counts.end());
        return std::distance(meeting_counts.begin(), max_it);
    }
};