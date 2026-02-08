#include <iostream>
#include <vector>
#include <queue>

using namespace std;

class Solution {
public:
    int captureForts(vector<int>& forts) {
        int n = forts.size();
        int maxCaptures = 0;
        for (int i = 0; i < n; ++i) {
            if (forts[i] == 1) {
                int j = i + 1;
                while (j < n && forts[j] == 0) {
                    ++j;
                }
                if (j < n && forts[j] == -1) {
                    maxCaptures = max(maxCaptures, j - i - 1);
                }
                j = i - 1;
                while (j >= 0 && forts[j] == 0) {
                    --j;
                }
                if (j >= 0 && forts[j] == -1) {
                    maxCaptures = max(maxCaptures, i - j - 1);
                }
            }
        }
        return maxCaptures;
    }
};