class Solution {
public:
    int maximumTastiness(vector<int>& price, int k) {
        sort(price.begin(), price.end());
        int left = 0, right = price.back() - price[0];
        int ans = 0;
        while (left <= right) {
            int mid = left + (right - left) / 2;
            if (canFormBasket(price, k, mid)) {
                ans = mid;
                left = mid + 1;
            } else {
                right = mid - 1;
            }
        }
        return ans;
    }

private:
    bool canFormBasket(vector<int>& price, int k, int minDiff) {
        int count = 1;
        int last = price[0];
        for (int i = 1; i < price.size(); ++i) {
            if (price[i] - last >= minDiff) {
                last = price[i];
                count++;
                if (count >= k) return true;
            }
        }
        return count >= k;
    }
};