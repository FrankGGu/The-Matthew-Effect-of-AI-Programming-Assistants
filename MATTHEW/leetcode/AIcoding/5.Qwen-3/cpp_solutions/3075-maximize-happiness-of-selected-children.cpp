#include <iostream>
#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    long long maxHappiness(vector<int>& happiness, int k) {
        sort(happiness.begin(), happiness.end(), greater<int>());
        long long total = 0;
        for (int i = 0; i < k; ++i) {
            if (happiness[i] <= 0) break;
            total += happiness[i] - i;
        }
        return total;
    }
};