#include <vector>
#include <numeric>
#include <algorithm>

class Solution {
public:
    int maxProfit(std::vector<int>& customers, int boardingCost, int runningCost) {
        long long total_customers_waiting = 0;
        long long total_boarded = 0;
        int total_rotations = 0;
        long long max_profit = 0; 
        int ans = -1; 

        int customer_idx = 0;
        int n = customers.size();

        while (customer_idx < n || total_customers_waiting > 0) {
            total_rotations++;

            if (customer_idx < n) {
                total_customers_waiting += customers[customer_idx];
                customer_idx++;
            }

            long long boarded_this_rotation = std::min((long long)4, total_customers_waiting);
            total_customers_waiting -= boarded_this_rotation;
            total_boarded += boarded_this_rotation;

            long long current_profit = total_boarded * boardingCost - (long long)total_rotations * runningCost;

            if (current_profit > max_profit) {
                max_profit = current_profit;
                ans = total_rotations;
            } else if (current_profit == max_profit && current_profit > 0) {
                ans = total_rotations;
            }
        }

        return ans;
    }
};