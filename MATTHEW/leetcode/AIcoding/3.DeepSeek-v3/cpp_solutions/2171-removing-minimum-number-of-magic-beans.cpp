#include <vector>
#include <algorithm>
#include <climits>

using namespace std;

class Solution {
public:
    long long minimumRemoval(vector<int>& beans) {
        sort(beans.begin(), beans.end());
        long long total = 0;
        for (int num : beans) {
            total += num;
        }
        long long min_beans = LLONG_MAX;
        int n = beans.size();
        for (int i = 0; i < n; ++i) {
            long long current = total - (long long)beans[i] * (n - i);
            if (current < min_beans) {
                min_beans = current;
            }
        }
        return min_beans;
    }
};