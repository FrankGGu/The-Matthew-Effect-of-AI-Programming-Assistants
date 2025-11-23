#include <iostream>
#include <vector>
#include <unordered_map>
#include <queue>

using namespace std;

class Solution {
public:
    vector<int> distanceToNearestHouse(vector<int>& s) {
        int n = s.size();
        vector<int> result(n, -1);
        queue<int> q;

        for (int i = 0; i < n; ++i) {
            if (s[i] == 1) {
                q.push(i);
                result[i] = 0;
            }
        }

        int dist = 1;
        while (!q.empty()) {
            int size = q.size();
            for (int i = 0; i < size; ++i) {
                int current = q.front();
                q.pop();

                for (int dir : {-1, 1}) {
                    int next = current + dir;
                    if (next >= 0 && next < n && result[next] == -1) {
                        result[next] = dist;
                        q.push(next);
                    }
                }
            }
            ++dist;
        }

        return result;
    }
};