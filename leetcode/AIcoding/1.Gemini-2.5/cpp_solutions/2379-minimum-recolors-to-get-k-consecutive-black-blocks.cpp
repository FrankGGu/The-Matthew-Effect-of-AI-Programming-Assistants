#include <string>
#include <algorithm>
#include <vector>

class Solution {
public:
    int minimumRecolors(std::string blocks, int k) {
        int n = blocks.length();
        int current_whites = 0;

        // Calculate whites in the first window of size k
        for (int i = 0; i < k; ++i) {
            if (blocks[i] == 'W') {
                current_whites++;
            }
        }

        int min_recolors = current_whites;

        // Slide the window
        for (int i = k; i < n; ++i) {
            // Remove the leftmost character from the window
            if (blocks[i - k] == 'W') {
                current_whites--;
            }
            // Add the new character to the right of the window
            if (blocks[i] == 'W') {
                current_whites++;
            }
            // Update the minimum recolors
            min_recolors = std::min(min_recolors, current_whites);
        }

        return min_recolors;
    }
};