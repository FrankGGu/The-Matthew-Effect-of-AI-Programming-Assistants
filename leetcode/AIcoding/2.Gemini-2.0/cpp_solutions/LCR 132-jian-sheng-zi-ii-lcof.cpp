#include <vector>
#include <cmath>
#include <iomanip>

using namespace std;

class Solution {
public:
    double minCost(vector<int>& bamboo) {
        int n = bamboo.size();
        double sum = 0;
        for (int x : bamboo) {
            sum += x;
        }
        double avg = sum / n;

        if (avg <= 1) {
            double cost = 0;
            for (int x : bamboo) {
                cost += (x - 1);
            }
            return cost;
        }

        double cost1 = 0;
        for (int x : bamboo) {
            cost1 += ceil(log2(x + 1e-9));
        }

        double cost2 = 0;
        for (int x : bamboo) {
            cost2 += floor(sqrt(x + 1e-9));
        }

        return min(cost1, cost2);
    }
};