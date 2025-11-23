#include <vector>

using namespace std;

class Solution {
public:
    int catMouseGame(vector<vector<int>>& graph) {
        int n = graph.size();
        vector<vector<vector<int>>> dp(n, vector<vector<int>>(n, vector<int>(2 * n, 0)));
        vector<vector<vector<int>>> degree(n, vector<vector<int>>(n, vector<int>(2 * n, 0)));

        for (int i = 0; i < n; ++i) {
            for (int j = 1; j < n; ++j) {
                for (int k = 0; k < 2 * n; ++k) {
                    if (k % 2 == 0) {
                        degree[i][j][k] = graph[i].size();
                    } else {
                        degree[i][j][k] = 0;
                        for (int next : graph[j]) {
                            if (next != 0) {
                                degree[i][j][k]++;
                            }
                        }
                    }
                }
            }
        }

        vector<tuple<int, int, int, int>> q;
        for (int i = 1; i < n; ++i) {
            dp[i][i][0] = 2;
            q.emplace_back(i, i, 0, 2);
            dp[i][i][1] = 2;
            q.emplace_back(i, i, 1, 2);
            dp[0][i][0] = 2;
            q.emplace_back(0, i, 0, 2);
            dp[0][i][1] = 2;
            q.emplace_back(0, i, 1, 2);
        }

        while (!q.empty()) {
            auto [mouse, cat, turn, result] = q.front();
            q.erase(q.begin());

            for (int prevMouse = 0; prevMouse < n; ++prevMouse) {
                for (int prevCat = 1; prevCat < n; ++prevCat) {
                    for (int prevTurn = 0; prevTurn < 2 * n; ++prevTurn) {
                        if ((prevTurn % 2 == 0 && prevMouse != mouse) || (prevTurn % 2 != 0 && prevCat != cat)) continue;
                        if ((prevTurn + 1) % 2 == 0) {
                            bool found = false;
                            for (int nextMouse : graph[prevMouse]) {
                                if (nextMouse == mouse && cat == prevCat) {
                                    if (dp[prevMouse][prevCat][prevTurn] == 0) {
                                        degree[prevMouse][prevCat][prevTurn]--;
                                        if (result == 1) {
                                            dp[prevMouse][prevCat][prevTurn] = 1;
                                            q.emplace_back(prevMouse, prevCat, prevTurn, 1);
                                        } else if (degree[prevMouse][prevCat][prevTurn] == 0) {
                                            dp[prevMouse][prevCat][prevTurn] = 2;
                                            q.emplace_back(prevMouse, prevCat, prevTurn, 2);
                                        }
                                        found = true;
                                    }
                                }
                            }
                        } else {
                            bool found = false;
                            for (int nextCat : graph[prevCat]) {
                                if (mouse == prevMouse && nextCat == cat) {
                                    if (dp[prevMouse][prevCat][prevTurn] == 0) {
                                        degree[prevMouse][prevCat][prevTurn]--;
                                        if (result == 1) {
                                            dp[prevMouse][prevCat][prevTurn] = 1;
                                            q.emplace_back(prevMouse, prevCat, prevTurn, 1);
                                        } else if (degree[prevMouse][prevCat][prevTurn] == 0) {
                                            dp[prevMouse][prevCat][prevTurn] = 2;
                                            q.emplace_back(prevMouse, prevCat, prevTurn, 2);
                                        }
                                        found = true;
                                    }
                                }
                            }
                        }
                        if ((prevTurn + 1) % 2 == 0 && prevMouse != mouse) continue;
                        if ((prevTurn + 1) % 2 != 0 && prevCat != cat) continue;
                        if (dp[prevMouse][prevCat][prevTurn] != 0) continue;

                        degree[prevMouse][prevCat][prevTurn]--;
                        if (result == 1) {
                            dp[prevMouse][prevCat][prevTurn] = 1;
                            q.emplace_back(prevMouse, prevCat, prevTurn, 1);
                        } else if (degree[prevMouse][prevCat][prevTurn] == 0) {
                            dp[prevMouse][prevCat][prevTurn] = 2;
                            q.emplace_back(prevMouse, prevCat, prevTurn, 2);
                        }
                    }
                }
            }
        }

        return dp[1][2][0];
    }
};