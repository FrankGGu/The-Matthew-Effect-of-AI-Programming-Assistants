#include <vector>
#include <algorithm>
#include <unordered_set>
#include <queue>

using namespace std;

class Solution {
public:
    vector<int> avoidFlood(vector<int>& rains) {
        int n = rains.size();
        vector<int> result(n, 1);
        unordered_set<int> lakes;
        priority_queue<int, vector<int>, greater<int>> dryDays;

        for (int i = 0; i < n; i++) {
            if (rains[i] == 0) {
                dryDays.push(i);
                result[i] = 1;
            } else {
                if (lakes.count(rains[i])) return {};
                lakes.insert(rains[i]);
                if (!dryDays.empty()) {
                    result[dryDays.top()] = rains[i];
                    dryDays.pop();
                } else {
                    return {};
                }
            }
        }

        return result;
    }
};