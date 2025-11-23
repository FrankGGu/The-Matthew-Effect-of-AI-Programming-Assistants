#include <iostream>
#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int maxEnergy(int n, vector<int>& energy) {
        int total = 0;
        for (int i = 0; i < n; ++i) {
            total += energy[i];
        }
        return total;
    }
};