#include <iostream>
#include <vector>
#include <algorithm>
#include <numeric>

using namespace std;

class Solution {
public:
    long long minSumOfThreeNumbers(vector<int>& a, vector<int>& b) {
        sort(a.begin(), a.end());
        sort(b.begin(), b.end());

        long long sumA = 0;
        long long sumB = 0;

        for (int i = 0; i < a.size(); ++i) {
            if (a[i] == 0) {
                a[i] = 1;
            }
            sumA += a[i];
        }

        for (int i = 0; i < b.size(); ++i) {
            if (b[i] == 0) {
                b[i] = 1;
            }
            sumB += b[i];
        }

        return sumA + sumB;
    }
};