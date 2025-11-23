#include <string>
#include <vector>
#include <sstream>

class Solution {
public:
    std::string simplifyPath(std::string path) {
        std::vector<std::string> stack;
        std::stringstream ss(path);
        std::string segment;

        while (std::getline(ss, segment, '/')) {
            if (segment == "" || segment == ".") {
                continue;
            } else if (segment == "..") {
                if (!stack.empty()) {
                    stack.pop_back();
                }
            } else {
                stack.push_back(segment);
            }
        }

        if (stack.empty()) {
            return "/";
        }

        std::string simplified_path = "";
        for (const std::string& dir : stack) {
            simplified_path += "/" + dir;
        }

        return simplified_path;
    }
};