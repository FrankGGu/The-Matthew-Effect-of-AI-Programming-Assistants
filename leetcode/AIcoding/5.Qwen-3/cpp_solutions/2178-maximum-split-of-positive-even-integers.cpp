#include <iostream>
#include <vector>

using namespace std;

class Solution {
public:
    vector<long long> maximumSplit(long long n) {
        vector<long long> result;
        if (n % 2 != 0) return result;

        long long half = n / 2;
        for (long long i = 1; i <= half - 1; i += 2) {
            result.push_back(i);
        }
        result.push_back(n - (half - 1));
        return result;
    }
};