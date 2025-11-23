#include <iostream>
#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int maximumRobots(vector<int>& costs, vector<int>& ranks, long long budget) {
        vector<pair<int, int>> robots;
        for (int i = 0; i < costs.size(); ++i) {
            robots.push_back({ranks[i], costs[i]});
        }
        sort(robots.begin(), robots.end());

        int n = robots.size();
        long long total = 0;
        int count = 0;
        int left = 0;

        for (int right = 0; right < n; ++right) {
            total += robots[right].second;
            while (total > budget) {
                total -= robots[left].second;
                left++;
            }
            count = max(count, right - left + 1);
        }

        return count;
    }
};