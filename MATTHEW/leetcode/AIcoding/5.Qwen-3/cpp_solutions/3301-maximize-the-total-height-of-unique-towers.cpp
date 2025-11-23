#include <iostream>
#include <vector>
#include <map>
#include <algorithm>

using namespace std;

class Solution {
public:
    long long maxTotalHeight(vector<int>& heights) {
        map<int, int> freq;
        for (int h : heights) {
            freq[h]++;
        }

        vector<int> uniqueHeights;
        for (auto& [h, count] : freq) {
            uniqueHeights.push_back(h);
        }

        sort(uniqueHeights.begin(), uniqueHeights.end());

        long long total = 0;
        int n = uniqueHeights.size();

        for (int i = 0; i < n; ++i) {
            int current = uniqueHeights[i];
            int left = i > 0 ? uniqueHeights[i - 1] : 0;
            int right = i < n - 1 ? uniqueHeights[i + 1] : 0;

            if (i == 0) {
                total += (long long)current * (current - left);
            } else if (i == n - 1) {
                total += (long long)current * (current - right);
            } else {
                int minNeighbor = min(left, right);
                total += (long long)current * (current - minNeighbor);
            }
        }

        return total;
    }
};