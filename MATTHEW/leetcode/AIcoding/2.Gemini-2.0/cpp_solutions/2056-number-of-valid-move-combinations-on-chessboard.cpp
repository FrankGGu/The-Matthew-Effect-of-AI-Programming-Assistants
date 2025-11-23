#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int countCombinations(vector<string>& pieces, vector<vector<int>>& positions) {
        int n = pieces.size();
        int ans = 0;

        vector<int> dx = {0, 0, 1, 1, 1, -1, -1, -1};
        vector<int> dy = {1, -1, 0, 1, -1, 0, 1, -1};

        function<void(int, vector<int>&)> solve = 
            [&](int k, vector<int>& directions) {
            if (k == n) {
                vector<vector<int>> pos = positions;
                vector<bool> stopped(n, false);
                bool valid = true;

                while (true) {
                    bool allStopped = true;
                    for (int i = 0; i < n; ++i) {
                        if (!stopped[i]) {
                            allStopped = false;
                            int x = pos[i][0] - 1;
                            int y = pos[i][1] - 1;
                            int dir = directions[i];
                            int nx = x + dx[dir];
                            int ny = y + dy[dir];

                            if (nx < 0 || nx >= 8 || ny < 0 || ny >= 8) {
                                stopped[i] = true;
                                continue;
                            }

                            bool collision = false;
                            for (int j = 0; j < n; ++j) {
                                if (i != j && pos[j][0] - 1 == nx && pos[j][1] - 1 == ny) {
                                    collision = true;
                                    break;
                                }
                            }
                            if (collision) {
                                stopped[i] = true;
                                continue;
                            }

                            pos[i][0] = nx + 1;
                            pos[i][1] = ny + 1;

                            for (int j = 0; j < n; ++j) {
                                if (i != j && pos[j][0] == nx + 1 && pos[j][1] == ny + 1 && !stopped[j]) {
                                    stopped[i] = true;
                                    break;
                                }
                            }
                        }
                    }

                    if (allStopped) {
                        ans++;
                        break;
                    }
                }
                return;
            }

            if (pieces[k] == "rook") {
                for (int d : {0, 1, 2, 5}) {
                    directions[k] = d;
                    solve(k + 1, directions);
                }
            } else if (pieces[k] == "bishop") {
                for (int d : {3, 4, 6, 7}) {
                    directions[k] = d;
                    solve(k + 1, directions);
                }
            } else {
                for (int d = 0; d < 8; ++d) {
                    directions[k] = d;
                    solve(k + 1, directions);
                }
            }
        };

        vector<int> directions(n);
        solve(0, directions);

        return ans;
    }
};