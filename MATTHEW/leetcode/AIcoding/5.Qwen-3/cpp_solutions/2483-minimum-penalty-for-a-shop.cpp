#include <iostream>
#include <vector>
#include <string>

using namespace std;

class Solution {
public:
    int minShopKeepersPenalty(string s) {
        int n = s.size();
        vector<int> left(n, 0);
        vector<int> right(n, 0);

        int count = 0;
        for (int i = 0; i < n; ++i) {
            left[i] = count;
            if (s[i] == 'Y') {
                count++;
            }
        }

        count = 0;
        for (int i = n - 1; i >= 0; --i) {
            right[i] = count;
            if (s[i] == 'Y') {
                count++;
            }
        }

        int minPenalty = INT_MAX;
        for (int i = 0; i < n; ++i) {
            minPenalty = min(minPenalty, left[i] + right[i]);
        }

        return minPenalty;
    }
};