#include <vector>
#include <queue>

using namespace std;

int minCost(int maxPositions, vector<int>& chargingStations, int start, int target, int gas) {
    chargingStations.push_back(start);
    chargingStations.push_back(target);
    sort(chargingStations.begin(), chargingStations.end());

    int n = chargingStations.size();
    vector<vector<long long>> dp(n, vector<long long>(gas + 1, -1));

    dp[0][gas] = 0;

    for (int i = 0; i < n - 1; ++i) {
        for (int j = 0; j <= gas; ++j) {
            if (dp[i][j] == -1) continue;

            int dist = chargingStations[i + 1] - chargingStations[i];

            if (dist <= j) {
                if (dp[i + 1][j - dist] == -1 || dp[i + 1][j - dist] > dp[i][j]) {
                    dp[i + 1][j - dist] = dp[i][j];
                }
            }

            for (int k = 1; k <= gas; ++k) {
                if (j + k <= gas) {
                    int next_pos = chargingStations[i] + k;
                    int next_station_index = -1;
                    for(int l = i + 1; l < n; ++l) {
                        if(chargingStations[l] <= next_pos) {
                            next_station_index = l;
                        } else {
                            break;
                        }
                    }

                    if(next_station_index != -1) {
                        int next_dist = chargingStations[next_station_index] - chargingStations[i];

                        if (next_dist <= j + k) {
                            if (dp[next_station_index][gas] == -1 || dp[next_station_index][gas] > dp[i][j] + k) {
                                dp[next_station_index][gas] = dp[i][j] + k;
                            }
                        }
                    }
                }
            }
        }
    }

    long long result = -1;
    for (int j = 0; j <= gas; ++j) {
        if (dp[n - 1][j] != -1) {
            if (result == -1 || dp[n - 1][j] < result) {
                result = dp[n - 1][j];
            }
        }
    }

    return (int)result;
}