#include <vector>
#include <algorithm> // Required for std::max

class Solution {
public:
    std::vector<int> replaceElements(std::vector<int>& arr) {
        int n = arr.size();
        if (n == 0) {
            return arr;
        }

        int max_so_far = -1; // Initialize with -1 as per problem for the last element

        // Iterate from right to left
        for (int i = n - 1; i >= 0; --i) {
            int current_element = arr[i];
            arr[i] = max_so_far;
            max_so_far = std::max(max_so_far, current_element);
        }

        return arr;
    }
};