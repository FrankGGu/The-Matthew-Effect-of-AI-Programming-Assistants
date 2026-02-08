#include <vector>
#include <string>
#include <algorithm>

class Solution {
public:
    int minOperations(std::vector<std::string>& logs) {
        int depth = 0;
        for (const std::string& log : logs) {
            if (log == "../") {
                depth = std::max(0, depth - 1);
            } else if (log == "./") {
                // Stay in the current folder, depth doesn't change
            } else {
                depth++;
            }
        }
        return depth;
    }
};