class Solution {
public:
    bool judgePoint24(vector<int>& cards) {
        vector<double> nums(cards.begin(), cards.end());
        return dfs(nums);
    }

private:
    bool dfs(vector<double>& nums) {
        if (nums.size() == 1) {
            return abs(nums[0] - 24) < 1e-6;
        }

        for (int i = 0; i < nums.size(); ++i) {
            for (int j = 0; j < nums.size(); ++j) {
                if (i == j) continue;

                vector<double> next;
                for (int k = 0; k < nums.size(); ++k) {
                    if (k != i && k != j) {
                        next.push_back(nums[k]);
                    }
                }

                for (int op = 0; op < 4; ++op) {
                    if (op == 0) next.push_back(nums[i] + nums[j]);
                    else if (op == 1) next.push_back(nums[i] - nums[j]);
                    else if (op == 2) next.push_back(nums[i] * nums[j]);
                    else if (op == 3 && nums[j] != 0) next.push_back(nums[i] / nums[j]);
                    else continue;

                    if (dfs(next)) return true;
                    next.pop_back();
                }
            }
        }
        return false;
    }
};