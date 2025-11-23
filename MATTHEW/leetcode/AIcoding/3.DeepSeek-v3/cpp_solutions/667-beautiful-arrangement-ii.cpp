class Solution {
public:
    vector<int> constructArray(int n, int k) {
        vector<int> res(n);
        int left = 1, right = n;
        for (int i = 0; i < n; ++i) {
            if (k > 1) {
                res[i] = (k % 2 == 1) ? left++ : right--;
                k--;
            } else {
                res[i] = left++;
            }
        }
        return res;
    }
};