#include <iostream>
#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int maxValueAfterReverse(vector<int>& A) {
        int n = A.size();
        if (n < 2) return 0;

        int maxVal = 0;
        int diff1 = 0, diff2 = 0;

        for (int i = 0; i < n - 1; ++i) {
            maxVal = max(maxVal, abs(A[i] - A[i + 1]));
        }

        for (int i = 0; i < n - 1; ++i) {
            int a = A[i], b = A[i + 1];
            int cost = abs(a - b);
            if (i > 0) {
                int prev = A[i - 1];
                int newCost = abs(prev - b);
                diff1 = max(diff1, newCost - cost);
            }
            if (i < n - 2) {
                int next = A[i + 2];
                int newCost = abs(a - next);
                diff2 = max(diff2, newCost - cost);
            }
        }

        return maxVal + max(diff1, diff2);
    }
};