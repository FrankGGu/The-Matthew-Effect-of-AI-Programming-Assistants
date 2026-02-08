class Solution {
public:
    bool containsPattern(vector<int>& arr, int m, int k) {
        int n = arr.size();
        for (int i = 0; i <= n - m * k; ++i) {
            bool found = true;
            for (int j = 0; j < m; ++j) {
                for (int l = 1; l < k; ++l) {
                    if (arr[i + j] != arr[i + j + l * m]) {
                        found = false;
                        break;
                    }
                }
                if (!found) break;
            }
            if (found) return true;
        }
        return false;
    }
};