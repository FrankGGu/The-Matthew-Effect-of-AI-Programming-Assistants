#include <vector>
#include <algorithm>
#include <cmath>

using namespace std;

class Solution {
public:
    int separateSquares(vector<int>& nums) {
        int n = nums.size();
        vector<double> a(n), b(n);
        for (int i = 0; i < n; ++i) {
            a[i] = nums[i];
            b[i] = 1.0;
        }

        double det = 0.0;
        for (int i = 0; i < n; ++i) {
            for (int j = i + 1; j < n; ++j) {
                det = (a[i] - a[j]) * (a[i] - a[j]) + (b[i] - b[j]) * (b[i] - b[j]);
                if (det < 1e-6) return false;
            }
        }

        return true;
    }
};