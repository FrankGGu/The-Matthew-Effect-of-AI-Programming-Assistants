class Solution {
public:
    double getProbability(vector<int>& balls) {
        int total = accumulate(balls.begin(), balls.end(), 0);
        int n = total / 2;
        vector<int> box1, box2;
        double valid = 0, totalCases = 0;
        backtrack(balls, 0, box1, box2, 0, 0, n, valid, totalCases);
        return valid / totalCases;
    }

private:
    void backtrack(vector<int>& balls, int idx, vector<int>& box1, vector<int>& box2, int cnt1, int cnt2, int n, double& valid, double& totalCases) {
        if (cnt1 > n || cnt2 > n) return;
        if (idx == balls.size()) {
            if (cnt1 != n || cnt2 != n) return;
            int distinct1 = 0, distinct2 = 0;
            for (int num : box1) if (num > 0) distinct1++;
            for (int num : box2) if (num > 0) distinct2++;
            if (distinct1 == distinct2) valid += getPermutation(box1) * getPermutation(box2);
            totalCases += getPermutation(box1) * getPermutation(box2);
            return;
        }

        for (int i = 0; i <= balls[idx]; ++i) {
            box1.push_back(i);
            box2.push_back(balls[idx] - i);
            backtrack(balls, idx + 1, box1, box2, cnt1 + i, cnt2 + balls[idx] - i, n, valid, totalCases);
            box1.pop_back();
            box2.pop_back();
        }
    }

    double getPermutation(vector<int>& box) {
        double res = 1.0;
        int sum = accumulate(box.begin(), box.end(), 0);
        vector<double> fact(sum + 1, 1.0);
        for (int i = 1; i <= sum; ++i) fact[i] = fact[i - 1] * i;
        res = fact[sum];
        for (int num : box) res /= fact[num];
        return res;
    }
};