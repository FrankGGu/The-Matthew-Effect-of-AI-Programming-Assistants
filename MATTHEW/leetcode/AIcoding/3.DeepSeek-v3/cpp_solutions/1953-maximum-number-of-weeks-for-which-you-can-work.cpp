#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    long long numberOfWeeks(vector<int>& milestones) {
        long long sum = 0;
        int max_val = 0;
        for (int m : milestones) {
            sum += m;
            max_val = max(max_val, m);
        }
        long long rest = sum - max_val;
        if (max_val > rest + 1) {
            return 2 * rest + 1;
        } else {
            return sum;
        }
    }
};