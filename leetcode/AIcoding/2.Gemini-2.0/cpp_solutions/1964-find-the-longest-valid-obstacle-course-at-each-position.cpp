#include <vector>

using namespace std;

class Solution {
public:
    vector<int> longestObstacleCourseAtEachPosition(vector<int>& obstacles) {
        int n = obstacles.size();
        vector<int> result(n);
        vector<int> tail;

        for (int i = 0; i < n; ++i) {
            int obstacle = obstacles[i];
            auto it = upper_bound(tail.begin(), tail.end(), obstacle);

            if (it == tail.end()) {
                tail.push_back(obstacle);
                result[i] = tail.size();
            } else {
                *it = obstacle;
                result[i] = distance(tail.begin(), it) + 1;
            }
        }

        return result;
    }
};