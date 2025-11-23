class Solution {
public:
    int stockManagement(vector<int>& stock) {
        int left = 0, right = stock.size() - 1;
        while (left < right) {
            int mid = left + (right - left) / 2;
            if (stock[mid] > stock[right]) {
                left = mid + 1;
            } else if (stock[mid] < stock[right]) {
                right = mid;
            } else {
                right--;
            }
        }
        return stock[left];
    }
};