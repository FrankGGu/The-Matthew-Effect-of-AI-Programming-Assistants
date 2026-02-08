class NumArray {
public:
    vector<int> nums;
    vector<int> bit;
    int n;

    NumArray(vector<int>& nums) {
        this->nums = nums;
        this->n = nums.size();
        bit.resize(n + 1, 0);
        for (int i = 0; i < n; i++) {
            updateBIT(i, nums[i]);
        }
    }

    void updateBIT(int i, int val) {
        i++;
        while (i <= n) {
            bit[i] += val;
            i += i & (-i);
        }
    }

    int getSum(int i) {
        i++;
        int sum = 0;
        while (i > 0) {
            sum += bit[i];
            i -= i & (-i);
        }
        return sum;
    }

    void update(int index, int val) {
        int diff = val - nums[index];
        nums[index] = val;
        updateBIT(index, diff);
    }

    int sumRange(int left, int right) {
        return getSum(right) - getSum(left - 1);
    }
};