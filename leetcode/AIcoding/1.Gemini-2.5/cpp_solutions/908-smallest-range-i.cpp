#include <vector>
#include <algorithm> // Required for std::max

class Solution {
public:
    int smallestRangeI(std::vector<int>& A, int K) {
        int min_val = A[0];
        int max_val = A[0];

        for (int i = 1; i < A.size(); ++i) {
            if (A[i] < min_val) {
                min_val = A[i];
            }
            if (A[i] > max_val) {
                max_val = A[i];
            }
        }

        // The smallest possible maximum value in B is max_val - K.
        // The largest possible minimum value in B is min_val + K.
        // The smallest possible difference between max(B) and min(B) is
        // (max_val - K) - (min_val + K).
        // If this value is negative, it means we can make all elements
        // fall into a range of zero difference.
        return std::max(0, (max_val - K) - (min_val + K));
    }
};