#include <vector>
#include <algorithm>

class Solution {
public:
    int maxNonDecreasingLength(std::vector<int>& A, std::vector<int>& B) {
        int n = A.size();
        int maxLength = 1;

        for (int i = 0; i < n; ++i) {
            int lenA = 1, lenB = 1;
            for (int j = i + 1; j < n; ++j) {
                if (A[j] >= A[j - 1]) lenA++;
                else if (B[j] >= A[j - 1]) lenB++;
                else break;
                maxLength = std::max(maxLength, lenA);
                maxLength = std::max(maxLength, lenB);
            }
        }

        return maxLength;
    }
};