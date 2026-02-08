#include <iostream>
#include <vector>

using namespace std;

class Solution {
public:
    int findChampion(int n, vector<vector<int>>& edges) {
        vector<int> inDegree(n, 0);
        for (const auto& edge : edges) {
            inDegree[edge[1]]++;
        }

        for (int i = 0; i < n; ++i) {
            if (inDegree[i] == 0) {
                return i;
            }
        }

        return -1;
    }
};