#include <vector>
#include <algorithm>
#include <set>
#include <unordered_map>

using namespace std;

class Solution {
public:
    vector<int> closestRoom(vector<vector<int>>& rooms, vector<int>& queries) {
        int n = rooms.size();
        vector<int> result(queries.size());
        vector<pair<int, int>> indexedQueries;
        for (int i = 0; i < queries.size(); ++i) {
            indexedQueries.emplace_back(queries[i], i);
        }
        sort(indexedQueries.rbegin(), indexedQueries.rend());

        vector<int> roomSize(n);
        for (int i = 0; i < n; ++i) {
            roomSize[i] = rooms[i][1];
        }
        sort(rooms.begin(), rooms.end(), [](const vector<int>& a, const vector<int>& b) {
            return a[1] > b[1];
        });

        set<int> availableRooms;
        int j = 0;

        for (const auto& [size, idx] : indexedQueries) {
            while (j < n && rooms[j][1] >= size) {
                availableRooms.insert(rooms[j][0]);
                ++j;
            }

            if (availableRooms.empty()) {
                result[idx] = -1;
            } else {
                int closest = -1;
                int minDiff = INT_MAX;
                for (int room : availableRooms) {
                    if (closest == -1 || abs(room - rooms[idx][0]) < minDiff) {
                        closest = room;
                        minDiff = abs(room - rooms[idx][0]);
                    }
                }
                result[idx] = closest;
            }
        }

        return result;
    }
};