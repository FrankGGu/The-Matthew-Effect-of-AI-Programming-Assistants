#include <iostream>
#include <vector>
#include <unordered_map>
#include <unordered_set>

using namespace std;

class Solution {
public:
    vector<int> gridIllumination(int n, vector<vector<int>>& queries, vector<vector<int>>& bricks) {
        unordered_map<int, int> row;
        unordered_map<int, int> col;
        unordered_map<int, int> diag1;
        unordered_map<int, int> diag2;
        unordered_set<long long> light;

        for (const auto& brick : bricks) {
            int x = brick[0], y = brick[1];
            long long key = static_cast<long long>(x) * n + y;
            if (light.find(key) == light.end()) {
                row[x]++;
                col[y]++;
                diag1[x - y]++;
                diag2[x + y]++;
                light.insert(key);
            }
        }

        vector<int> result;
        for (const auto& query : queries) {
            int x = query[0], y = query[1];
            long long key = static_cast<long long>(x) * n + y;
            if (light.find(key) != light.end()) {
                result.push_back(1);
                row[x]--;
                col[y]--;
                diag1[x - y]--;
                diag2[x + y]--;
                light.erase(key);
            } else {
                result.push_back(0);
            }
        }

        return result;
    }
};