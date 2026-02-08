#include <vector>
#include <algorithm> // For std::max

class Solution {
public:
    bool isIdealPermutation(std::vector<int>& A) {
        int n = A.size();

        // max_val_prefix will store the maximum value encountered in A[0...i-2]
        // when we are checking A[i].
        // Initialize to -1 because array elements are non-negative (0 to n-1).
        int max_val_prefix = -1; 

        for (int i = 0; i < n; ++i) {
            // When checking A[i], we need to ensure it's not smaller than any A[k]
            // where k <= i-2. This means A[i] must not be smaller than max(A[0], ..., A[i-2]).

            // This condition ensures that we have at least A[0], A[1], and A[2] available.
            // When i=2, we need max(A[0]). max_val_prefix will be updated with A[0].
            // When i=3, we need max(A[0], A[1]). max_val_prefix will be updated with A[1].
            // And so on.
            if (i >= 2) { 
                max_val_prefix = std::max(max_val_prefix, A[i-2]);
            }

            // At this point, max_val_prefix correctly holds max(A[0], ..., A[i-2]) 
            // (or -1 if i < 2, meaning no elements in that range).
            // If A[i] is less than max_val_prefix, it means there exists some k <= i-2
            // such that A[k] > A[i]. This (k, i) pair is a global inversion that is not local.
            if (A[i] < max_val_prefix) {
                return false;
            }
        }

        // If the loop completes, no such non-local global inversion was found.
        // Therefore, all global inversions must be local inversions.
        return true;
    }
};