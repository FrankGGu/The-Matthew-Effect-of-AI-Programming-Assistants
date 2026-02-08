#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int minimumEffort(vector<vector<int>>& tasks) {
        sort(tasks.begin(), tasks.end(), [](const auto& a, const auto& b) {
            return (a[1] - a[0]) > (b[1] - b[0]);
        });

        int energy = 0;
        for (const auto& task : tasks) {
            if (energy < task[1]) {
                energy = task[1];
            }
            energy -= task[0];
        }

        return energy + (energy < 0 ? abs(energy) : 0);
    }
};