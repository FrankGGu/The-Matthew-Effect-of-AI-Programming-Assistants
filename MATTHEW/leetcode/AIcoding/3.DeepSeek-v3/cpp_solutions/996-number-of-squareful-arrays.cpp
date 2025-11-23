class Solution {
public:
    int numSquarefulPerms(vector<int>& nums) {
        sort(nums.begin(), nums.end());
        vector<int> path;
        vector<bool> used(nums.size(), false);
        int res = 0;
        backtrack(nums, path, used, res);
        return res;
    }

private:
    void backtrack(vector<int>& nums, vector<int>& path, vector<bool>& used, int& res) {
        if (path.size() == nums.size()) {
            res++;
            return;
        }

        for (int i = 0; i < nums.size(); i++) {
            if (used[i]) continue;
            if (i > 0 && nums[i] == nums[i-1] && !used[i-1]) continue;
            if (!path.empty() && !isSquare(path.back() + nums[i])) continue;

            used[i] = true;
            path.push_back(nums[i]);
            backtrack(nums, path, used, res);
            path.pop_back();
            used[i] = false;
        }
    }

    bool isSquare(int num) {
        int root = sqrt(num);
        return root * root == num;
    }
};