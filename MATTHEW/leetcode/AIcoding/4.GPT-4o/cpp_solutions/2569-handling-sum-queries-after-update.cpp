class NumArray {
public:
    NumArray(vector<int>& nums) {
        n = nums.size();
        data.assign(n + 1, 0);
        for (int i = 0; i < n; ++i) {
            update(i, nums[i]);
        }
    }

    void update(int index, int val) {
        int diff = val - sum(index, index);
        for (int i = index + 1; i <= n; ++i) {
            data[i] += diff;
        }
    }

    int sumRange(int left, int right) {
        return sum(right) - sum(left - 1);
    }

private:
    vector<int> data;
    int n;

    int sum(int index) {
        int total = 0;
        for (int i = index + 1; i > 0; i -= i & -i) {
            total += data[i];
        }
        return total;
    }
};