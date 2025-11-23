#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int minimizedMaximum(int n, vector<int>& quantities) {
        int left = 1, right = *max_element(quantities.begin(), quantities.end());
        int ans = right;
        while (left <= right) {
            int mid = left + (right - left) / 2;
            long long count = 0;
            for (int quantity : quantities) {
                count += (quantity + mid - 1) / mid;
            }
            if (count <= n) {
                ans = mid;
                right = mid - 1;
            } else {
                left = mid + 1;
            }
        }
        return ans;
    }
};