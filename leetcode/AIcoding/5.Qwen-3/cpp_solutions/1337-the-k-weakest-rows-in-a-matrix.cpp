#include <iostream>
#include <vector>
#include <queue>
#include <unordered_map>

using namespace std;

class Solution {
public:
    vector<int> kWeakestRows(vector<vector<int>>& mat, int k) {
        vector<pair<int, int>> strength;
        for (int i = 0; i < mat.size(); ++i) {
            int count = 0;
            for (int j = 0; j < mat[i].size(); ++j) {
                if (mat[i][j] == 1) {
                    ++count;
                }
            }
            strength.push_back({count, i});
        }

        auto compare = [](const pair<int, int>& a, const pair<int, int>& b) {
            return a.first != b.first ? a.first < b.first : a.second < b.second;
        };

        priority_queue<pair<int, int>, vector<pair<int, int>>, decltype(compare)> pq(compare);

        for (const auto& s : strength) {
            pq.push(s);
            if (pq.size() > k) {
                pq.pop();
            }
        }

        vector<int> result(k);
        for (int i = k - 1; i >= 0; --i) {
            result[i] = pq.top().second;
            pq.pop();
        }

        return result;
    }
};