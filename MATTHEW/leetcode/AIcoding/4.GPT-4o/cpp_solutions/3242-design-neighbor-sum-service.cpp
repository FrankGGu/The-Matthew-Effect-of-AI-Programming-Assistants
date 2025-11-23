class NeighborSum {
public:
    NeighborSum(vector<int>& nums) {
        this->nums = nums;
        n = nums.size();
    }

    void update(int i, int val) {
        nums[i] = val;
    }

    int sum(int i) {
        int total = 0;
        if (i > 0) total += nums[i - 1];
        if (i < n - 1) total += nums[i + 1];
        return total;
    }

private:
    vector<int> nums;
    int n;
};