class Solution {
public:
    vector<int> closestRoom(vector<vector<int>>& rooms, vector<vector<int>>& queries) {
        int n = rooms.size();
        int m = queries.size();
        vector<int> res(m, -1);

        for (int i = 0; i < m; ++i) {
            queries[i].push_back(i);
        }

        sort(rooms.begin(), rooms.end(), [](const vector<int>& a, const vector<int>& b) {
            return a[1] < b[1];
        });

        sort(queries.begin(), queries.end(), [](const vector<int>& a, const vector<int>& b) {
            return a[1] < b[1];
        });

        set<int> ids;
        int j = n - 1;

        for (int i = m - 1; i >= 0; --i) {
            int pref = queries[i][0];
            int minSize = queries[i][1];
            int idx = queries[i][2];

            while (j >= 0 && rooms[j][1] >= minSize) {
                ids.insert(rooms[j][0]);
                --j;
            }

            if (ids.empty()) {
                res[idx] = -1;
                continue;
            }

            auto it = ids.lower_bound(pref);
            int id1 = (it != ids.end()) ? *it : -1;
            int id2 = (it != ids.begin()) ? *prev(it) : -1;

            if (id1 == -1) {
                res[idx] = id2;
            } else if (id2 == -1) {
                res[idx] = id1;
            } else {
                if (abs(id1 - pref) < abs(id2 - pref)) {
                    res[idx] = id1;
                } else {
                    res[idx] = id2;
                }
            }
        }

        return res;
    }
};