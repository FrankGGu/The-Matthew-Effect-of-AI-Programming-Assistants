#include <vector>
#include <string>

class Solution {
public:
    std::vector<std::string> buildArray(std::vector<int>& target, int n) {
        std::vector<std::string> operations;
        int current_target_idx = 0;

        for (int i = 1; i <= n; ++i) {
            if (current_target_idx == target.size()) {
                break; 
            }

            operations.push_back("Push");

            if (i == target[current_target_idx]) {
                current_target_idx++;
            } else {
                operations.push_back("Pop");
            }
        }

        return operations;
    }
};