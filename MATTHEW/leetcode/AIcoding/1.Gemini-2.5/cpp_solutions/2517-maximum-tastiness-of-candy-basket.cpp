#include <vector>
#include <algorithm>

class Solution {
public:
    int maximumTastiness(std::vector<int>& price, int k) {
        std::sort(price.begin(), price.end());
        int n = price.size();
        int left = 0;
        int right = price[n - 1] - price[0];
        int ans = 0;

        auto can_achieve = [&](int d) {
            int count = 1;
            int last_price = price[0];
            for (int i = 1; i < n; ++i) {
                if (price[i] - last_price >= d) {
                    count++;
                    last_price = price[i];
                }
            }
            return count >= k;
        };

        while (left <= right) {
            int mid = left + (right - left) / 2;
            if (can_achieve(mid)) {
                ans = mid;
                left = mid + 1;
            } else {
                right = mid - 1;
            }
        }

        return ans;
    }
};