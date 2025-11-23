#include <iostream>
#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int maxActiveSections(vector<int>& trade, int k) {
        int n = trade.size();
        vector<int> prefix(n + 1, 0);
        for (int i = 0; i < n; ++i) {
            prefix[i + 1] = prefix[i] + trade[i];
        }

        int result = 0;
        for (int i = 0; i < n; ++i) {
            int left = i;
            int right = min(i + k, n);
            int sum = prefix[right] - prefix[left];
            if (sum > 0) {
                result++;
            }
        }

        return result;
    }
};