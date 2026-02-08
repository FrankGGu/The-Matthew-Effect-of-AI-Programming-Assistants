class NeighborSumService {
private:
    vector<int> nums;
    vector<int> prefixSum;
public:
    NeighborSumService(vector<int>& nums) {
        this->nums = nums;
        prefixSum.resize(nums.size() + 1, 0);
        for (int i = 0; i < nums.size(); ++i) {
            prefixSum[i + 1] = prefixSum[i] + nums[i];
        }
    }

    void update(int index, int val) {
        int diff = val - nums[index];
        nums[index] = val;
        for (int i = index + 1; i < prefixSum.size(); ++i) {
            prefixSum[i] += diff;
        }
    }

    int sumRange(int left, int right) {
        return prefixSum[right + 1] - prefixSum[left];
    }

    int neighborSum(int index) {
        int left = max(0, index - 1);
        int right = min((int)nums.size() - 1, index + 1);
        return sumRange(left, right);
    }
};