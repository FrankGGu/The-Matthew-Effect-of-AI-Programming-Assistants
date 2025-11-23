class Solution {
public:
    int minDays(vector<int>& bloomDay, int m, int k) {
        if (m * k > bloomDay.size()) return -1;
        int left = 1, right = *max_element(bloomDay.begin(), bloomDay.end());
        while (left < right) {
            int mid = left + (right - left) / 2;
            if (canMake(bloomDay, m, k, mid)) {
                right = mid;
            } else {
                left = mid + 1;
            }
        }
        return left;
    }

private:
    bool canMake(vector<int>& bloomDay, int m, int k, int day) {
        int bouquets = 0, flowers = 0;
        for (int d : bloomDay) {
            if (d <= day) {
                flowers++;
                if (flowers == k) {
                    bouquets++;
                    flowers = 0;
                }
            } else {
                flowers = 0;
            }
            if (bouquets >= m) return true;
        }
        return bouquets >= m;
    }
};