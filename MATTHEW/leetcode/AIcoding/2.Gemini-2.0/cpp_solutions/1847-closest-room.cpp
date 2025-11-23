#include <vector>
#include <algorithm>

using namespace std;

vector<int> closestRoom(vector<vector<int>>& rooms, vector<vector<int>>& queries) {
    int n = rooms.size();
    int m = queries.size();
    vector<int> ans(m);

    vector<pair<int, int>> q_idx(m);
    for (int i = 0; i < m; ++i) {
        q_idx[i] = {i, queries[i][1]};
    }
    sort(q_idx.begin(), q_idx.end(), [](const auto& a, const auto& b) {
        return a.second > b.second;
    });

    sort(rooms.begin(), rooms.end(), [](const auto& a, const auto& b) {
        return a[1] > b[1];
    });

    int j = 0;
    vector<int> valid_rooms;
    for (int i = 0; i < m; ++i) {
        int idx = q_idx[i].first;
        int minSize = q_idx[i].second;
        int preferred = queries[idx][0];

        while (j < n && rooms[j][1] >= minSize) {
            valid_rooms.push_back(rooms[j][0]);
            j++;
        }

        if (valid_rooms.empty()) {
            ans[idx] = -1;
        } else {
            int closest = valid_rooms[0];
            int min_diff = abs(valid_rooms[0] - preferred);
            for (int room : valid_rooms) {
                int diff = abs(room - preferred);
                if (diff < min_diff) {
                    min_diff = diff;
                    closest = room;
                } else if (diff == min_diff && room < closest) {
                    closest = room;
                }
            }
            ans[idx] = closest;
        }
    }

    return ans;
}