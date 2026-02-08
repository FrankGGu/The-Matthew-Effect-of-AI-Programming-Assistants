#include <vector>
#include <algorithm>

class Solution {
public:
    std::vector<int> replaceElements(std::vector<int>& arr) {
        int n = arr.size();
        if (n == 0) {
            return {};
        }

        int max_so_far = -1; // Initialize with -1 as per problem for the last element

        // Iterate from right to left
        for (int i = n - 1; i >= 0; --i) {
            int current_element = arr[i]; // Store current element
            arr[i] = max_so_far;          // Replace current element with max from its right
            max_so_far = std::max(max_so_far, current_element); // Update max_so_far
        }

        return arr;
    }
};