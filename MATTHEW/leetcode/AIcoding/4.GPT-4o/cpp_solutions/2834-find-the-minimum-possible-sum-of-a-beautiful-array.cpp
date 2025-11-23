class Solution {
public:
    int minimumPossibleSum(int n, int target) {
        vector<int> used(target, 0);
        int sum = 0, count = 0, num = 1;

        while (count < n) {
            if (num < target && !used[target - num]) {
                sum += num;
                used[num] = 1;
                count++;
            }
            num++;
        }

        return sum;
    }
};