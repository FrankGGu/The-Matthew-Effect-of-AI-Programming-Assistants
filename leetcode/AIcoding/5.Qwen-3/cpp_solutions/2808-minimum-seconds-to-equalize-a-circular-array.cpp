#include <iostream>
#include <vector>
#include <unordered_map>
#include <algorithm>

using namespace std;

class Solution {
public:
    int minSeconds(int n, vector<int>& s) {
        unordered_map<char, vector<int>> pos;
        for (int i = 0; i < n; ++i) {
            pos[s[i]].push_back(i);
        }

        int maxDist = 0;
        for (auto& [ch, indices] : pos) {
            int m = indices.size();
            for (int i = 0; i < m; ++i) {
                int j = (i + 1) % m;
                int dist = min(abs(indices[i] - indices[j]), n - abs(indices[i] - indices[j]));
                maxDist = max(maxDist, dist);
            }
        }

        return maxDist;
    }
};