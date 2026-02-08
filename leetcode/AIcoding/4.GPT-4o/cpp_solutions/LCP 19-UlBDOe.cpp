class Solution {
public:
    int collectTheCoins(vector<int>& coins) {
        int n = coins.size();
        if (n < 3) return 0;

        int left = 0, right = n - 1;
        while (left < n && coins[left] == 0) left++;
        while (right >= 0 && coins[right] == 0) right--;

        if (left >= right) return 0;

        while (left <= right) {
            if (coins[left] == 1) {
                left++;
            } else {
                break;
            }
        }

        while (right >= left) {
            if (coins[right] == 1) {
                right--;
            } else {
                break;
            }
        }

        return max(0, right - left + 1) + (right >= left ? 2 : 0);
    }
};