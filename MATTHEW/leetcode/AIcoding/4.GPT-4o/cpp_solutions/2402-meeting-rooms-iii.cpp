#include <vector>
#include <queue>
#include <algorithm>

using namespace std;

class Solution {
public:
    int mostBooked(int n, vector<vector<int>>& meetings) {
        sort(meetings.begin(), meetings.end());
        priority_queue<pair<long long, int>, vector<pair<long long, int>>, greater<pair<long long, int>>> available;
        priority_queue<pair<long long, int>, vector<pair<long long, int>>> ongoing;

        for (int i = 0; i < n; ++i) {
            available.push({0, i});
        }

        vector<int> count(n, 0);
        for (const auto& meeting : meetings) {
            long long start = meeting[0], end = meeting[1];

            while (!ongoing.empty() && ongoing.top().first <= start) {
                auto [finishTime, room] = ongoing.top();
                ongoing.pop();
                available.push({finishTime, room});
            }

            if (!available.empty()) {
                auto [finishTime, room] = available.top();
                available.pop();
                count[room]++;
                ongoing.push({finishTime + (end - start), room});
            } else {
                auto [finishTime, room] = ongoing.top();
                ongoing.pop();
                count[room]++;
                ongoing.push({finishTime + (end - start), room});
            }
        }

        int maxCount = 0, resRoom = 0;
        for (int i = 0; i < n; ++i) {
            if (count[i] > maxCount || (count[i] == maxCount && i < resRoom)) {
                maxCount = count[i];
                resRoom = i;
            }
        }
        return resRoom;
    }
};