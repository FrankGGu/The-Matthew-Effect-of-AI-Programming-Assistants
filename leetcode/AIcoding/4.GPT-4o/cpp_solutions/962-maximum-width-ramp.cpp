class Solution {
public:
    int maxWidthRamp(vector<int>& A) {
        int n = A.size();
        int max_width = 0;
        vector<int> min_index(n);

        min_index[0] = 0;
        for (int i = 1; i < n; ++i) {
            min_index[i] = (A[i] < A[min_index[i - 1]]) ? i : min_index[i - 1];
        }

        for (int j = n - 1; j > 0; --j) {
            while (min_index[j] < j && A[min_index[j]] <= A[j]) {
                max_width = max(max_width, j - min_index[j]);
                --min_index[j];
            }
            max_width = max(max_width, j - min_index[j]);
        }

        return max_width;
    }
};