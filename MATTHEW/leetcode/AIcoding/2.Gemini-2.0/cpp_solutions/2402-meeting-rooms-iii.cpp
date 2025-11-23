#include <vector>
#include <algorithm>
#include <queue>

using namespace std;

class Solution {
public:
    int mostBooked(int n, vector<vector<int>>& meetings) {
        sort(meetings.begin(), meetings.end());
        vector<long long> room_available(n, 0);
        vector<int> room_count(n, 0);
        priority_queue<int, vector<int>, greater<int>> available_rooms;
        for (int i = 0; i < n; ++i) {
            available_rooms.push(i);
        }

        for (auto& meeting : meetings) {
            int start = meeting[0];
            int end = meeting[1];

            while (!available_rooms.empty() && room_available[available_rooms.top()] <= start) {
                available_rooms.pop();
            }

            vector<int> rooms_to_readd;
            for (int i = 0; i < n; ++i) {
                if (room_available[i] <= start) {
                    rooms_to_readd.push_back(i);
                }
            }

            for(int room : rooms_to_readd){
                available_rooms.push(room);
            }

            if (!available_rooms.empty()) {
                int room_id = available_rooms.top();
                available_rooms.pop();
                room_count[room_id]++;
                room_available[room_id] = end;
            } else {
                long long min_available = room_available[0];
                int room_id = 0;
                for (int i = 1; i < n; ++i) {
                    if (room_available[i] < min_available) {
                        min_available = room_available[i];
                        room_id = i;
                    }
                }
                room_count[room_id]++;
                room_available[room_id] += (end - start);
            }
        }

        int max_count = 0;
        int best_room = 0;
        for (int i = 0; i < n; ++i) {
            if (room_count[i] > max_count) {
                max_count = room_count[i];
                best_room = i;
            }
        }

        return best_room;
    }
};