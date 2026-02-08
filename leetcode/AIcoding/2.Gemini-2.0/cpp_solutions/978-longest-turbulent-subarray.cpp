#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int maxTurbulenceSize(vector<int>& arr) {
        int n = arr.size();
        if (n < 2) return n;

        int ans = 1;
        int l = 0;
        int r = 0;

        while (r < n - 1) {
            if (arr[r] == arr[r + 1]) {
                l = r + 1;
            } else if (r > l && ((arr[r - 1] < arr[r] && arr[r] > arr[r + 1]) || (arr[r - 1] > arr[r] && arr[r] < arr[r + 1]))) {
                // do nothing
            } else {
                l = r;
            }
            r++;
            ans = max(ans, r - l + 1);
        }

        return ans;
    }
};