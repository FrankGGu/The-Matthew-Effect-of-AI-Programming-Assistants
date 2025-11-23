#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int maximumPopulation(vector<vector<int>>& logs) {
        vector<int> diff(101, 0);
        for (auto& log : logs) {
            diff[log[0] - 1950]++;
            diff[log[1] - 1950]--;
        }

        int maxPop = 0;
        int maxYear = 1950;
        int currentPop = 0;
        for (int i = 0; i < 101; ++i) {
            currentPop += diff[i];
            if (currentPop > maxPop) {
                maxPop = currentPop;
                maxYear = i + 1950;
            }
        }

        return maxYear;
    }
};