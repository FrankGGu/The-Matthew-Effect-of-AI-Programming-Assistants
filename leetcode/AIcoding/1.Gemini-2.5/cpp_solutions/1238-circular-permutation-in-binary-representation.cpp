#include <vector>
#include <cmath> // Not strictly needed, 1 << n is better for powers of 2

class Solution {
public:
    std::vector<int> circularPermutation(int n, int start) {
        std::vector<int> result;
        int size = 1 << n; // Calculate 2^n

        for (int i = 0; i < size; ++i) {
            // Generate the i-th element of the Gray code sequence
            // The standard Gray code for i is i ^ (i >> 1)
            // To make the sequence start with 'start', XOR each element with 'start'
            result.push_back((i ^ (i >> 1)) ^ start);
        }

        return result;
    }
};