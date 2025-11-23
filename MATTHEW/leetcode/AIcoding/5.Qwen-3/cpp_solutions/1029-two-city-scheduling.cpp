#include <iostream>
#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int twoCityScheduling(vector<int>& costs) {
        sort(costs.begin(), costs.end(), [](const int& a, const int& b) {
            return (a % 100) < (b % 100);
        });

        int total = 0;
        for (int i = 0; i < costs.size() / 2; ++i) {
            total += costs[i] % 100;
        }

        for (int i = costs.size() / 2; i < costs.size(); ++i) {
            total += costs[i] / 100;
        }

        return total;
    }
};