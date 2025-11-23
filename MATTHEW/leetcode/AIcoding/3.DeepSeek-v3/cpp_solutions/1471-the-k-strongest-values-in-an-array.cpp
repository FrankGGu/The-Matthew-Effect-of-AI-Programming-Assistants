class Solution {
public:
    vector<int> getStrongest(vector<int>& arr, int k) {
        sort(arr.begin(), arr.end());
        int n = arr.size();
        int m = arr[(n - 1) / 2];

        auto cmp = [m](int a, int b) {
            int diffA = abs(a - m);
            int diffB = abs(b - m);
            if (diffA == diffB) {
                return a > b;
            } else {
                return diffA > diffB;
            }
        };

        sort(arr.begin(), arr.end(), cmp);

        vector<int> result(arr.begin(), arr.begin() + k);
        return result;
    }
};