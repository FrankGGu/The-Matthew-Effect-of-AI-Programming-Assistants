#include <vector>

using namespace std;

class Solution {
public:
    int findChampion(int n, vector<vector<int>>& edges) {
        vector<int> inDegree(n, 0);
        for (auto& edge : edges) {
            inDegree[edge[1]]++;
        }

        int champion = -1;
        int count = 0;
        for (int i = 0; i < n; ++i) {
            if (inDegree[i] == 0) {
                champion = i;
                count++;
            }
        }

        if (count == 1) {
            return champion;
        } else {
            return -1;
        }
    }
};