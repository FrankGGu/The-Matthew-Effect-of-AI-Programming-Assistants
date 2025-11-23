class Solution {
public:
    int maxDecks(vector<int>& A, vector<int>& B) {
        int n = A.size(), m = B.size();
        sort(A.begin(), A.end());
        sort(B.begin(), B.end());
        int i = 0, j = 0, count = 0;

        while (i < n && j < m) {
            if (A[i] < B[j]) {
                count++;
                i++;
            }
            j++;
        }

        return count;
    }
};