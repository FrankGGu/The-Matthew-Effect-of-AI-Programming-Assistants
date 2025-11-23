#include <vector>
#include <algorithm>

class Solution {
public:
    int maximumTastiness(std::vector<int>& price, int k) {
        std::sort(price.begin(), price.end());
        int left = 0, right = price.back() - price.front();
        int result = 0;

        while (left <= right) {
            int mid = left + (right - left) / 2;
            if (canChoose(price, k, mid)) {
                result = mid;
                left = mid + 1;
            } else {
                right = mid - 1;
            }
        }
        return result;
    }

private:
    bool canChoose(std::vector<int>& price, int k, int mid) {
        int count = 1, lastChosen = price[0];
        for (int i = 1; i < price.size(); ++i) {
            if (price[i] - lastChosen >= mid) {
                count++;
                lastChosen = price[i];
                if (count == k) return true;
            }
        }
        return false;
    }
};