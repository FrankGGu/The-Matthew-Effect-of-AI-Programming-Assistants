#include <iostream>
#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    long long minAdjacentSwaps(int n, int k) {
        vector<int> positions;
        for (int i = 0; i < n; ++i) {
            if (i % k == 0) {
                positions.push_back(i);
            }
        }

        long long res = 0;
        for (int i = 0; i < positions.size(); ++i) {
            res += abs(positions[i] - (i * k));
        }

        return res;
    }
};