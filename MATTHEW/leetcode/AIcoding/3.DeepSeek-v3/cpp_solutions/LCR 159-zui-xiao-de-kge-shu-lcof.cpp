class Solution {
public:
    vector<int> inventoryManagement(vector<int>& stock, int cnt) {
        if (cnt >= stock.size()) return stock;
        vector<int> res;
        int left = 0, right = stock.size() - 1;
        int index = partition(stock, left, right);
        while (index != cnt - 1) {
            if (index > cnt - 1) {
                right = index - 1;
            } else {
                left = index + 1;
            }
            index = partition(stock, left, right);
        }
        res.assign(stock.begin(), stock.begin() + cnt);
        return res;
    }

    int partition(vector<int>& nums, int left, int right) {
        int pivot = nums[left];
        int i = left, j = right;
        while (i < j) {
            while (i < j && nums[j] >= pivot) j--;
            while (i < j && nums[i] <= pivot) i++;
            if (i < j) swap(nums[i], nums[j]);
        }
        swap(nums[left], nums[i]);
        return i;
    }
};