class Solution {
public:
    bool sumGame(string num) {
        int n = num.size();
        long long leftSum = 0, leftUnknowns = 0, rightSum = 0, rightUnknowns = 0;

        for (int i = 0; i < n / 2; ++i) {
            if (num[i] == '?') {
                leftUnknowns++;
            } else {
                leftSum += num[i] - '0';
            }
        }

        for (int i = n / 2; i < n; ++i) {
            if (num[i] == '?') {
                rightUnknowns++;
            } else {
                rightSum += num[i] - '0';
            }
        }

        long long leftTotal = leftSum + leftUnknowns * 9;
        long long rightTotal = rightSum + rightUnknowns * 0;

        return leftTotal != rightTotal;
    }
};