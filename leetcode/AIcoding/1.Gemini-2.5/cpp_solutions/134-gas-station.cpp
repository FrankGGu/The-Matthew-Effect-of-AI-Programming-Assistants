#include <vector>
#include <numeric>

class Solution {
public:
    int canCompleteCircuit(std::vector<int>& gas, std::vector<int>& cost) {
        int n = gas.size();
        int total_tank = 0;
        int current_tank = 0;
        int start_station = 0;

        for (int i = 0; i < n; ++i) {
            total_tank += gas[i] - cost[i];
            current_tank += gas[i] - cost[i];

            if (current_tank < 0) {
                start_station = i + 1;
                current_tank = 0;
            }
        }

        return total_tank >= 0 ? start_station : -1;
    }
};