#include <vector>
#include <cmath>
#include <algorithm> // For std::reverse

class Solution {
public:
    std::vector<int> pathInZigZagTree(int label) {
        std::vector<int> path;
        int current_label = label;

        while (current_label > 0) {
            path.push_back(current_label);
            if (current_label == 1) {
                break;
            }

            // Determine the 1-indexed level of the current_label.
            // For example:
            // 1 is level 1
            // 2, 3 are level 2
            // 4, 5, 6, 7 are level 3
            // log2(N) gives the 0-indexed level, so add 1 for 1-indexed.
            int level = static_cast<int>(std::floor(std::log2(current_label))) + 1;
            int parent_level = level - 1;

            // Calculate the minimum and maximum values for the parent's level.
            // For a 1-indexed level 'k', the range is [2^(k-1), 2^k - 1].
            // So for parent_level 'p', the range is [2^(p-1), 2^p - 1].
            int min_parent_val = 1 << (parent_level - 1); // Equivalent to pow(2, parent_level - 1)
            int max_parent_val = (1 << parent_level) - 1; // Equivalent to pow(2, parent_level) - 1

            // In a standard complete binary tree (left-to-right labelling at all levels),
            // the parent of a node N is N/2 (integer division).
            // This 'standard_parent_val' is the value the parent *would have* if
            // the tree was labelled in a standard manner at all levels.
            int standard_parent_val = current_label / 2;

            // Now, we need to find the *actual* zigzag label for this parent.
            // The parent_level's parity determines its labelling direction.
            if (parent_level % 2 == 1) {
                // If parent_level is odd (e.g., level 1, 3, 5...), it's labelled L-R.
                // In this case, the standard_parent_val is already its actual zigzag label.
                current_label = standard_parent_val;
            } else {
                // If parent_level is even (e.g., level 2, 4, 6...), it's labelled R-L.
                // The standard_parent_val needs to be "mirrored" within its level's range
                // to get its actual zigzag label.
                // The mirroring formula for a value X in a range [A, B] is A + B - X.
                current_label = min_parent_val + max_parent_val - standard_parent_val;
            }
        }

        // The path was collected from label up to root, so it's in reverse order.
        std::reverse(path.begin(), path.end());
        return path;
    }
};