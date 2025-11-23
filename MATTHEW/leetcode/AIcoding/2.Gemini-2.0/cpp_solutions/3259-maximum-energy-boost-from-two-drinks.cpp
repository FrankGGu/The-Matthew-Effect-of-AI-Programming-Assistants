#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int maxEnergyBoost(vector<int>& drinks) {
        sort(drinks.begin(), drinks.end());
        return drinks[drinks.size() - 1] + drinks[drinks.size() - 2];
    }
};