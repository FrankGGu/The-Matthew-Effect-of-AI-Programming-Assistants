class ProductArray {
public:
    vector<long long> prefix;

    ProductArray(vector<int>& nums) {
        int n = nums.size();
        prefix.resize(n + 1, 1);
        for (int i = 1; i <= n; ++i) {
            prefix[i] = prefix[i - 1] * nums[i - 1];
        }
    }

    long long rangeProduct(int left, int right) {
        return prefix[right + 1] / prefix[left];
    }
};