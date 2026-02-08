class Solution {
public:
    bool judgePoint24(vector<int>& nums) {
        return dfs(nums);
    }

private:
    bool dfs(vector<double> nums) {
        if (nums.size() == 1) {
            return abs(nums[0] - 24) < 1e-6;
        }
        for (int i = 0; i < nums.size(); i++) {
            for (int j = 0; j < nums.size(); j++) {
                if (i != j) {
                    vector<double> next;
                    for (int k = 0; k < nums.size(); k++) {
                        if (k != i && k != j) {
                            next.push_back(nums[k]);
                        }
                    }
                    for (double result : compute(nums[i], nums[j])) {
                        next.push_back(result);
                        if (dfs(next)) {
                            return true;
                        }
                        next.pop_back();
                    }
                }
            }
        }
        return false;
    }

    vector<double> compute(double a, double b) {
        vector<double> results;
        results.push_back(a + b);
        results.push_back(a - b);
        results.push_back(b - a);
        results.push_back(a * b);
        if (b != 0) results.push_back(a / b);
        if (a != 0) results.push_back(b / a);
        return results;
    }
};