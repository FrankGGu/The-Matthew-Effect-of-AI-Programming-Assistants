#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int countBuildings(vector<vector<int>>& buildings) {
        if (buildings.empty()) return 0;

        sort(buildings.begin(), buildings.end(), [](const vector<int>& a, const vector<int>& b) {
            return a[0] < b[0];
        });

        int count = 1;
        int n = buildings.size();
        int max_height = buildings[0][1];
        int max_right = buildings[0][2];

        for (int i = 1; i < n; ++i) {
            if (buildings[i][0] > max_right) {
                count++;
                max_height = buildings[i][1];
                max_right = buildings[i][2];
            } else if (buildings[i][1] > max_height) {
                count++;
                max_height = buildings[i][1];
                max_right = max(max_right, buildings[i][2]);
            } else {
                max_right = max(max_right, buildings[i][2]);
            }
        }

        return count;
    }
};