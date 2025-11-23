#include <iostream>
#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int minimumRemovals(vector<int>& a) {
        int n = a.size();
        vector<int> left(n, 1), right(n, 1);

        for (int i = 1; i < n; ++i) {
            for (int j = 0; j < i; ++j) {
                if (a[j] < a[i]) {
                    left[i] = max(left[i], left[j] + 1);
                }
            }
        }

        for (int i = n - 2; i >= 0; --i) {
            for (int j = n - 1; j > i; --j) {
                if (a[j] < a[i]) {
                    right[i] = max(right[i], right[j] + 1);
                }
            }
        }

        int result = 0;
        for (int i = 0; i < n; ++i) {
            if (left[i] > 1 && right[i] > 1) {
                result = max(result, left[i] + right[i] - 1);
            }
        }

        return n - result;
    }
};