#include <vector>
#include <unordered_map>
#include <queue>

using namespace std;

class Solution {
public:
    vector<int> volunteerDeployment(vector<int>& finalCnt, long long totalNum, vector<vector<int>>& edges, vector<vector<int>>& plans) {
        int n = finalCnt.size() + 1;
        vector<vector<int>> adj(n);
        for (const auto& e : edges) {
            adj[e[0]].push_back(e[1]);
            adj[e[1]].push_back(e[0]);
        }

        unordered_map<int, long long> coeff;
        unordered_map<int, long long> constant;
        coeff[0] = 1;
        constant[0] = 0;
        for (int i = 1; i < n; ++i) {
            coeff[i] = 0;
            constant[i] = finalCnt[i - 1];
        }

        for (int i = plans.size() - 1; i >= 0; --i) {
            int num = plans[i][0];
            int idx = plans[i][1];
            if (num == 1) {
                coeff[idx] *= 2;
                constant[idx] *= 2;
            } else {
                for (int neighbor : adj[idx]) {
                    if (num == 2) {
                        coeff[neighbor] -= coeff[idx];
                        constant[neighbor] -= constant[idx];
                    } else if (num == 3) {
                        coeff[neighbor] += coeff[idx];
                        constant[neighbor] += constant[idx];
                    }
                }
            }
        }

        long long sumCoeff = 0;
        long long sumConst = 0;
        for (int i = 0; i < n; ++i) {
            sumCoeff += coeff[i];
            sumConst += constant[i];
        }

        long long x = (totalNum - sumConst) / sumCoeff;

        vector<int> res(n);
        for (int i = 0; i < n; ++i) {
            res[i] = coeff[i] * x + constant[i];
        }

        return res;
    }
};