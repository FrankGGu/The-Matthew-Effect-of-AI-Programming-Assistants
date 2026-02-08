#include <iostream>
#include <vector>
#include <unordered_map>

using namespace std;

class Solution {
public:
    int findChampion(int n, vector<vector<int>>& picks) {
        unordered_map<int, int> degree;
        for (const auto& pick : picks) {
            int a = pick[0];
            int b = pick[1];
            degree[b]++;
        }

        for (int i = 0; i < n; ++i) {
            if (degree.find(i) == degree.end()) {
                return i;
            }
        }

        return -1;
    }
};