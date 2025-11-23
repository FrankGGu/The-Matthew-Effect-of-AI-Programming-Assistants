class Solution {
public:
    int minDays(vector<int>& bloomDay, int m, int k) {
        int n = bloomDay.size();
        if (m * k > n) return -1;

        int left = *min_element(bloomDay.begin(), bloomDay.end());
        int right = *max_element(bloomDay.begin(), bloomDay.end());

        auto canMakeBouquets = [&](int days) {
            int bouquets = 0, flowers = 0;
            for (int day : bloomDay) {
                if (day <= days) {
                    flowers++;
                    if (flowers == k) {
                        bouquets++;
                        flowers = 0;
                    }
                } else {
                    flowers = 0;
                }
            }
            return bouquets >= m;
        };

        while (left < right) {
            int mid = left + (right - left) / 2;
            if (canMakeBouquets(mid)) {
                right = mid;
            } else {
                left = mid + 1;
            }
        }
        return left;
    }
};