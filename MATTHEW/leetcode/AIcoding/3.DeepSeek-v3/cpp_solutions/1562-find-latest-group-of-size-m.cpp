class Solution {
public:
    int findLatestStep(vector<int>& arr, int m) {
        int n = arr.size();
        if (n == m) return n;
        vector<int> length(n + 2, 0);
        int res = -1;
        for (int i = 0; i < n; ++i) {
            int a = arr[i];
            int left = length[a - 1];
            int right = length[a + 1];
            int total = left + right + 1;
            length[a - left] = total;
            length[a + right] = total;
            if (left == m || right == m) {
                res = i;
            }
        }
        return res;
    }
};