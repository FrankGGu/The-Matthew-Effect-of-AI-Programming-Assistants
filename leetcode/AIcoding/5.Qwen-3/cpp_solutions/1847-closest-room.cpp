#include <iostream>
#include <vector>
#include <queue>
#include <unordered_map>
#include <algorithm>

using namespace std;

class Solution {
public:
    vector<int> closestRoom(vector<vector<int>>& rooms, vector<vector<int>>& queries) {
        int n = rooms.size();
        int q = queries.size();
        vector<int> result(q, 0);

        vector<pair<int, int>> sortedRooms;
        for (int i = 0; i < n; ++i) {
            sortedRooms.push_back({rooms[i][1], rooms[i][0]});
        }
        sort(sortedRooms.begin(), sortedRooms.end());

        vector<pair<int, int>> sortedQueries;
        for (int i = 0; i < q; ++i) {
            sortedQueries.push_back({queries[i][1], i});
        }
        sort(sortedQueries.begin(), sortedQueries.end());

        vector<int> roomIds(n);
        for (int i = 0; i < n; ++i) {
            roomIds[i] = sortedRooms[i].second;
        }

        int roomIndex = 0;
        priority_queue<pair<int, int>> availableRooms;

        for (int i = 0; i < q; ++i) {
            int queryId = sortedQueries[i].second;
            int preferredRoom = sortedQueries[i].first;

            while (roomIndex < n && sortedRooms[roomIndex].first >= preferredRoom) {
                availableRooms.push({sortedRooms[roomIndex].first, roomIds[roomIndex]});
                ++roomIndex;
            }

            if (availableRooms.empty()) {
                result[queryId] = -1;
            } else {
                int bestRoom = availableRooms.top().second;
                int minDistance = abs(bestRoom - preferredRoom);
                while (!availableRooms.empty() && availableRooms.top().first == minDistance) {
                    int currentRoom = availableRooms.top().second;
                    if (abs(currentRoom - preferredRoom) < minDistance) {
                        minDistance = abs(currentRoom - preferredRoom);
                        bestRoom = currentRoom;
                    } else if (abs(currentRoom - preferredRoom) == minDistance && currentRoom < bestRoom) {
                        bestRoom = currentRoom;
                    }
                    availableRooms.pop();
                }
                result[queryId] = bestRoom;
            }
        }

        return result;
    }
};