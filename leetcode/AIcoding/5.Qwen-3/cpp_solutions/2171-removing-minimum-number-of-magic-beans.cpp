#include <iostream>
#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    long long minimumRemoval(vector<int>& beans) {
        sort(beans.begin(), beans.end());
        long long total = 0;
        for (int bean : beans) {
            total += bean;
        }
        long long minRemoval = total;
        int n = beans.size();
        for (int i = 0; i < n; ++i) {
            long long current = static_cast<long long>(beans[i]) * (n - i);
            minRemoval = min(minRemoval, total - current);
        }
        return minRemoval;
    }
};