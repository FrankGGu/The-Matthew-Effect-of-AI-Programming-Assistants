#include <string>
#include <vector>
#include <utility>

class Solution {
public:
    std::string removeDuplicates(std::string s, int k) {
        std::vector<std::pair<char, int>> stack;

        for (char c : s) {
            if (stack.empty() || stack.back().first != c) {
                stack.push_back({c, 1});
            } else {
                stack.back().second++;
                if (stack.back().second == k) {
                    stack.pop_back();
                }
            }
        }

        std::string result = "";
        for (const auto& p : stack) {
            result.append(p.second, p.first);
        }

        return result;
    }
};