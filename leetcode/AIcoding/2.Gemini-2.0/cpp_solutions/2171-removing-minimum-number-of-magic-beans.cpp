#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    long long minimumRemoval(vector<int>& beans) {
        sort(beans.begin(), beans.end());
        long long n = beans.size();
        long long totalSum = 0;
        for (int bean : beans) {
            totalSum += bean;
        }
        long long minRemoval = totalSum;
        for (int i = 0; i < n; ++i) {
            long long removal = totalSum - (long long)beans[i] * (n - i);
            minRemoval = min(minRemoval, removal);
        }
        return minRemoval;
    }
};