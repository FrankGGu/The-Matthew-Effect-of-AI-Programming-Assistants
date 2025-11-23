class Solution {
public:
    int maxAbsValExpr(vector<int>& arr1, vector<int>& arr2) {
        int n = arr1.size();
        int max1 = INT_MIN, max2 = INT_MIN, max3 = INT_MIN, max4 = INT_MIN;
        int min1 = INT_MAX, min2 = INT_MAX, min3 = INT_MAX, min4 = INT_MAX;

        for (int i = 0; i < n; ++i) {
            int val1 = arr1[i] + arr2[i] + i;
            int val2 = arr1[i] + arr2[i] - i;
            int val3 = arr1[i] - arr2[i] + i;
            int val4 = arr1[i] - arr2[i] - i;

            max1 = max(max1, val1);
            min1 = min(min1, val1);

            max2 = max(max2, val2);
            min2 = min(min2, val2);

            max3 = max(max3, val3);
            min3 = min(min3, val3);

            max4 = max(max4, val4);
            min4 = min(min4, val4);
        }

        int res1 = max1 - min1;
        int res2 = max2 - min2;
        int res3 = max3 - min3;
        int res4 = max4 - min4;

        return max({res1, res2, res3, res4});
    }
};