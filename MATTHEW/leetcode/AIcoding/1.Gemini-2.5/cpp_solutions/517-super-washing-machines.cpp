#include <vector>
#include <numeric>
#include <algorithm>

class Solution {
public:
    int findMinMoves(std::vector<int>& machines) {
        int n = machines.size();
        long long totalDresses = 0;
        for (int dresses : machines) {
            totalDresses += dresses;
        }

        if (totalDresses % n != 0) {
            return -1;
        }

        int target = totalDresses / n;
        int maxMoves = 0;
        int currentBalance = 0; // Represents the net flow of dresses needed to pass this point

        for (int dresses : machines) {
            int diff = dresses - target;
            currentBalance += diff;

            // maxMoves is the maximum of two things:
            // 1. The maximum number of dresses a single machine needs to get rid of.
            //    (If diff > 0, this machine has a surplus that must be moved out)
            // 2. The maximum absolute cumulative imbalance (flow) across any point.
            //    (abs(currentBalance) represents the maximum number of dresses that must pass through a boundary)
            maxMoves = std::max({maxMoves, diff, std::abs(currentBalance)});
        }

        return maxMoves;
    }
};