class Solution {
public:
    int maximumSum(vector<int>& arr) {
        int n = arr.size();
        if (n == 1) return arr[0];

        vector<int> noDelete(n);
        vector<int> oneDelete(n);

        noDelete[0] = arr[0];
        oneDelete[0] = 0;
        int res = max(noDelete[0], oneDelete[0]);

        for (int i = 1; i < n; ++i) {
            noDelete[i] = max(arr[i], noDelete[i-1] + arr[i]);
            oneDelete[i] = max(noDelete[i-1], oneDelete[i-1] + arr[i]);
            res = max(res, max(noDelete[i], oneDelete[i]));
        }

        return res;
    }
};