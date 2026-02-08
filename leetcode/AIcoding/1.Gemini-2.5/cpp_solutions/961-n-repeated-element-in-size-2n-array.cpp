#include <vector>
#include <numeric> // Not strictly needed for this solution, but often included.

class Solution {
public:
    int repeatedNElement(std::vector<int>& A) {
        // The problem states that an array A has 2N elements.
        // There are N+1 unique elements, and exactly one of them is repeated N times.
        // All other N elements appear exactly once.
        //
        // Due to the high frequency (N times in a 2N array), the repeated element
        // must appear close to another instance of itself.
        // Specifically, it can be proven that the repeated element X must satisfy
        // A[i] == A[i+1] or A[i] == A[i+2] or A[i] == A[i+3] for some index i.
        //
        // Proof sketch:
        // Assume for contradiction that no such close pair exists.
        // This implies that any two occurrences of the repeated element X must be at least 4 positions apart.
        // If X appears at indices p_1 < p_2 < ... < p_N, then p_k - p_{k-1} >= 4 for all k.
        // Thus, p_N - p_1 >= (N-1) * 4.
        // Since p_1 >= 0 and p_N <= 2N - 1 (array length is 2N), we have:
        // 2N - 1 >= (N-1) * 4
        // 2N - 1 >= 4N - 4
        // 3 >= 2N
        // N <= 1.5
        // However, the problem constraints state A.length >= 2, which means 2N >= 2, so N >= 1.
        // If N=1, A.length=2, the array is [X,X]. Here A[0] == A[1], which is A[i] == A[i+1].
        // If N >= 2, then N <= 1.5 is a contradiction.
        // Therefore, our initial assumption must be false, meaning at least one such close pair must exist.
        //
        // We can iterate through the array and check these conditions.

        for (int i = 0; i < A.size() - 1; ++i) {
            // Check for adjacent duplicates
            if (A[i] == A[i+1]) {
                return A[i];
            }
            // Check for duplicates with one element in between
            // Ensure i+2 is a valid index
            if (i + 2 < A.size() && A[i] == A[i+2]) {
                return A[i];
            }
            // Check for duplicates with two elements in between
            // Ensure i+3 is a valid index
            if (i + 3 < A.size() && A[i] == A[i+3]) {
                return A[i];
            }
        }

        // According to the proof, one of the above conditions must be met.
        // This line should theoretically not be reached if the input adheres to problem constraints.
        return -1; 
    }
};