#include <vector>
#include <string>
#include <algorithm>

class Solution {
public:
    std::vector<std::string> removeSubfolders(std::vector<std::string>& folder) {
        std::sort(folder.begin(), folder.end());

        std::vector<std::string> result;
        if (folder.empty()) {
            return result;
        }

        result.push_back(folder[0]);

        for (size_t i = 1; i < folder.size(); ++i) {
            std::string prefix = result.back() + '/';
            if (folder[i].rfind(prefix, 0) != 0) {
                result.push_back(folder[i]);
            }
        }

        return result;
    }
};