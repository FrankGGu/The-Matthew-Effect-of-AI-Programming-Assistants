class Solution {
public:
    long long maxMatrixSum(vector<vector<int>>& matrix) {
        int count_neg = 0;
        int min_abs = INT_MAX;
        long long sum = 0;

        for (auto& row : matrix) {
            for (int num : row) {
                if (num < 0) {
                    count_neg++;
                }
                int abs_num = abs(num);
                sum += abs_num;
                if (abs_num < min_abs) {
                    min_abs = abs_num;
                }
            }
        }

        if (count_neg % 2 == 0) {
            return sum;
        } else {
            return sum - 2 * min_abs;
        }
    }
};