#include <vector>
#include <numeric>
#include <algorithm>

class Solution {
public:
    int max_achievable_requests;
    int num_buildings;
    std::vector<std::vector<int>> all_requests;

    void solve(int k, int current_requests_count, std::vector<int>& building_balance) {
        if (current_requests_count + (all_requests.size() - k) < max_achievable_requests) {
            return;
        }

        if (k == all_requests.size()) {
            bool all_zero = true;
            for (int i = 0; i < num_buildings; ++i) {
                if (building_balance[i] != 0) {
                    all_zero = false;
                    break;
                }
            }
            if (all_zero) {
                max_achievable_requests = std::max(max_achievable_requests, current_requests_count);
            }
            return;
        }

        solve(k + 1, current_requests_count, building_balance);

        int from = all_requests[k][0];
        int to = all_requests[k][1];

        building_balance[from]--;
        building_balance[to]++;

        solve(k + 1, current_requests_count + 1, building_balance);

        building_balance[from]++;
        building_balance[to]--;
    }

    int maximumRequests(int n, std::vector<std::vector<int>>& requests) {
        num_buildings = n;
        all_requests = requests;
        max_achievable_requests = 0;
        std::vector<int> building_balance(n, 0);
        solve(0, 0, building_balance);
        return max_achievable_requests;
    }
};