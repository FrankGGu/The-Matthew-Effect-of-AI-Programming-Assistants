#include <iostream>
#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int minInitialEnergy(vector<vector<int>>& tasks) {
        int n = tasks.size();
        vector<pair<int, int>> taskPairs(n);

        for (int i = 0; i < n; ++i) {
            taskPairs[i] = {tasks[i][0], tasks[i][1]};
        }

        sort(taskPairs.begin(), taskPairs.end(), [](const pair<int, int>& a, const pair<int, int>& b) {
            return a.first - a.second < b.first - b.second;
        });

        int energy = 0;
        for (const auto& task : taskPairs) {
            energy += task.first;
            if (energy < task.second) {
                energy = task.second;
            }
        }

        return energy;
    }
};