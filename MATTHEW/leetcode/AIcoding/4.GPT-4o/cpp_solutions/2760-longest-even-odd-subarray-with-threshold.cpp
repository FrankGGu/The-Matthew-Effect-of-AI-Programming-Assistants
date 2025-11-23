class Solution {
public:
    int longestEvensOdds(vector<int>& A, int threshold) {
        int n = A.size();
        int maxLength = 0;
        int currentLength = 0;

        for (int i = 0; i < n; ++i) {
            if (A[i] <= threshold) {
                currentLength++;
            } else {
                currentLength = 0;
            }

            if (currentLength > 0 && (currentLength % 2 == 0 || currentLength % 2 == 1)) {
                maxLength = max(maxLength, currentLength);
            }
        }

        return maxLength;
    }
};