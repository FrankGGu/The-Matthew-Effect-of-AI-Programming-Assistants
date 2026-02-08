#include <iostream>
#include <vector>
#include <climits>

using namespace std;

class Solution {
public:
    int minTrainingHours(vector<int>& energy, vector<int>& training) {
        int n = energy.size();
        int total = 0;
        for (int i = 0; i < n; ++i) {
            if (training[i] < energy[i]) {
                total += energy[i] - training[i];
            }
        }
        return total;
    }
};