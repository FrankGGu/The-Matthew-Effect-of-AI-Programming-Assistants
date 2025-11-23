#include <iostream>
#include <vector>
#include <cmath>

using namespace std;

class Solution {
public:
    vector<long long> result;

    void applyOperations(long long a, long long b, long long c, long long d, long long n) {
        for (long long i = 0; i < n; ++i) {
            result.push_back(a * i + b);
        }

        for (long long i = 0; i < n; ++i) {
            result[i] = result[i] * c + d;
        }
    }

    vector<long long> getSequence(long long a, long long b, long long c, long long d, long long n) {
        result.clear();
        applyOperations(a, b, c, d, n);
        return result;
    }
};