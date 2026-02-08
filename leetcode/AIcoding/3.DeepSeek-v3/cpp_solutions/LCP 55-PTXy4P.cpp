#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int getMinimumTime(vector<int>& time, vector<vector<int>>& fruits, int limit) {
        int total = 0;
        for (const auto& fruit : fruits) {
            int type = fruit[0];
            int num = fruit[1];
            int cnt = (num + limit - 1) / limit;
            total += cnt * time[type];
        }
        return total;
    }
};