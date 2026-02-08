class Solution {
public:
    int mostBooked(int n, vector<vector<int>>& meetings) {
        sort(meetings.begin(), meetings.end());
        priority_queue<pair<long long, int>, vector<pair<long long, int>>, greater<pair<long long, int>>> busy;
        priority_queue<int, vector<int>, greater<int>> available;
        vector<int> count(n, 0);

        for (int i = 0; i < n; ++i) {
            available.push(i);
        }

        for (auto& meeting : meetings) {
            int start = meeting[0], end = meeting[1];

            while (!busy.empty() && busy.top().first <= start) {
                available.push(busy.top().second);
                busy.pop();
            }

            if (!available.empty()) {
                int room = available.top();
                available.pop();
                busy.push({end, room});
                count[room]++;
            } else {
                auto [time, room] = busy.top();
                busy.pop();
                busy.push({time + end - start, room});
                count[room]++;
            }
        }

        int maxCount = 0, result = 0;
        for (int i = 0; i < n; ++i) {
            if (count[i] > maxCount) {
                maxCount = count[i];
                result = i;
            }
        }
        return result;
    }
};