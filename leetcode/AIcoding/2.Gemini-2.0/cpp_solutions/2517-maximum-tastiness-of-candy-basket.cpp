#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int maximumTastiness(vector<int>& price, int k) {
        sort(price.begin(), price.end());
        int low = 0, high = price.back() - price[0];
        int ans = 0;

        while (low <= high) {
            int mid = low + (high - low) / 2;
            int count = 1;
            int prev = price[0];

            for (int i = 1; i < price.size(); ++i) {
                if (price[i] - prev >= mid) {
                    count++;
                    prev = price[i];
                }
            }

            if (count >= k) {
                ans = mid;
                low = mid + 1;
            } else {
                high = mid - 1;
            }
        }

        return ans;
    }
};