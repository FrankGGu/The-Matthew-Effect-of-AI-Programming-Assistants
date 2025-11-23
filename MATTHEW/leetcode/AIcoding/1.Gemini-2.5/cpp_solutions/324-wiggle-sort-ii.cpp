#include <vector>
#include <algorithm>
#include <functional> // For std::nth_element

class Solution {
public:
    void wiggleSort(std::vector<int>& nums) {
        int n = nums.size();

        // Find the median using nth_element.
        // nth_element partitions the array such that the element at the nth position
        // is the element that would be in that position in a sorted sequence.
        // Elements before it are less than or equal, elements after it are greater than or equal.
        // We pick the element at index n/2 as the median.
        std::nth_element(nums.begin(), nums.begin() + n / 2, nums.end());
        int median = nums[n / 2];

        // Define a custom index mapping function.
        // This mapping ensures that:
        // - Virtual indices 0, 1, ... map to odd physical indices.
        // - Virtual indices n/2, ..., n-1 map to even physical indices.
        // The modulo base (n | 1) ensures it's always an odd number,
        // which helps distribute elements evenly across odd and even physical indices.
        // Example for n=6 (n|1 = 7):
        // A(0) = (1 + 2*0) % 7 = 1
        // A(1) = (1 + 2*1) % 7 = 3
        // A(2) = (1 + 2*2) % 7 = 5
        // A(3) = (1 + 2*3) % 7 = 0
        // A(4) = (1 + 2*4) % 7 = 2
        // A(5) = (1 + 2*5) % 7 = 4
        auto A = [&](int idx) {
            return (1 + 2 * idx) % (n | 1);
        };

        // Three-way partitioning (Dutch National Flag algorithm) using virtual indices.
        // The goal is to arrange elements such that:
        // - Elements greater than the median are placed at A(0), A(1), ... (odd physical indices).
        // - Elements less than the median are placed at ..., A(n-2), A(n-1) (even physical indices).
        // - Elements equal to the median fill the remaining spots.
        int i = 0; // Pointer for the "greater than median" section (moves from left in virtual space)
        int j = 0; // Current element pointer (moves from left in virtual space)
        int k = n - 1; // Pointer for the "less than median" section (moves from right in virtual space)

        while (j <= k) {
            if (nums[A(j)] > median) {
                // Current element (at A(j)) is greater than median.
                // Swap it with the element at A(i) (which should also be > median or is the boundary).
                // Advance both i and j.
                std::swap(nums[A(i++)], nums[A(j++)]);
            } else if (nums[A(j)] < median) {
                // Current element (at A(j)) is less than median.
                // Swap it with the element at A(k) (which should be < median or is the boundary).
                // Only decrement k. The element swapped into A(j) needs to be re-evaluated.
                std::swap(nums[A(j)], nums[A(k--)]);
            } else {
                // Current element (at A(j)) is equal to median.
                // It's in its correct "middle" partition. Advance j.
                j++;
            }
        }
    }
};