class Solution {
public:
    int getKth(int lo, int hi, int k) {
        vector<pair<int, int>> nums;
        for (int i = lo; i <= hi; ++i) {
            nums.emplace_back(getPower(i), i);
        }
        sort(nums.begin(), nums.end());
        return nums[k - 1].second;
    }

private:
    int getPower(int x) {
        int steps = 0;
        while (x != 1) {
            if (x % 2 == 0) {
                x /= 2;
            } else {
                x = 3 * x + 1;
            }
            steps++;
        }
        return steps;
    }
};