#include <iostream>
#include <vector>
#include <cmath>

using namespace std;

class Solution {
public:
    int superWashingMachines(vector<int>& machines) {
        int total = 0;
        for (int m : machines) {
            total += m;
        }
        int n = machines.size();
        if (total % n != 0) {
            return -1;
        }
        int avg = total / n;
        int result = 0;
        int balance = 0;
        for (int i = 0; i < n; ++i) {
            balance += machines[i] - avg;
            result = max(result, abs(balance));
        }
        return result;
    }
};