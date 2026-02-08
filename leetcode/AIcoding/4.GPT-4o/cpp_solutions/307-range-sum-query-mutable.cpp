class NumArray {
public:
    vector<int> nums;
    vector<int> tree;
    int n;

    NumArray(vector<int>& nums) {
        this->nums = nums;
        n = nums.size();
        tree.resize(n + 1, 0);
        for (int i = 0; i < n; i++) {
            update(i + 1, nums[i]);
        }
    }

    void update(int index, int val) {
        int diff = val - nums[index - 1];
        nums[index - 1] = val;
        for (int i = index; i <= n; i += i & -i) {
            tree[i] += diff;
        }
    }

    int sumRange(int left, int right) {
        return sum(right + 1) - sum(left);
    }

    int sum(int index) {
        int total = 0;
        for (int i = index; i > 0; i -= i & -i) {
            total += tree[i];
        }
        return total;
    }
};