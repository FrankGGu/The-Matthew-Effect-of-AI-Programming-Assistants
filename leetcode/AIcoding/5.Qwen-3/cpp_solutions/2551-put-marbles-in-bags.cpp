#include <iostream>
#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    long long numberOfWays(vector<int>& marbles, int k) {
        sort(marbles.begin(), marbles.end());
        long long result = 1;
        for (int i = 0; i < k - 1; ++i) {
            result *= (marbles.size() - i - 1);
            result /= (i + 1);
        }
        return result;
    }
};