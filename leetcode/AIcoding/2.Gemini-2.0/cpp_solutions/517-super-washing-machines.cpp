#include <vector>
#include <numeric>
#include <algorithm>

using namespace std;

class Solution {
public:
    int findMinMoves(vector<int>& machines) {
        int sum = accumulate(machines.begin(), machines.end(), 0);
        int n = machines.size();
        if (sum % n != 0) return -1;
        int avg = sum / n;
        int ans = 0, balance = 0;
        for (int load : machines) {
            balance += load - avg;
            ans = max(ans, max(abs(balance), load - avg));
        }
        return ans;
    }
};