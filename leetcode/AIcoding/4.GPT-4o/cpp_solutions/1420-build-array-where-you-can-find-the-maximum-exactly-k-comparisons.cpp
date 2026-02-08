class Solution {
public:
    vector<int> maxArray(int n, int m, int k) {
        vector<int> result;
        for (int i = 0; i < n; ++i) {
            if (i < k) {
                result.push_back(m - i);
            } else {
                result.push_back(1);
            }
        }
        return result;
    }
};