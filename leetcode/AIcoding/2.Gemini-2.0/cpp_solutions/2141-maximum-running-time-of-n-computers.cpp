#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    long long maxRunTime(int n, vector<int>& batteries) {
        long long sum = 0;
        for (int battery : batteries) {
            sum += battery;
        }
        sort(batteries.begin(), batteries.end());
        int m = batteries.size();
        while (batteries[m - 1] > sum / n) {
            sum -= batteries[m - 1];
            n--;
            m--;
        }
        return sum / n;
    }
};