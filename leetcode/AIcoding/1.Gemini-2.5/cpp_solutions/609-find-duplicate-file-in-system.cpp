#include <vector>
#include <string>
#include <unordered_map>
#include <sstream>

class Solution {
public:
    std::vector<std::vector<std::string>> findDuplicate(std::vector<std::string>& paths) {
        std::unordered_map<std::string, std::vector<std::string>> contentMap;
        for (const std::string& path : paths) {
            std::stringstream ss(path);
            std::string directory;
            std::string file;

            ss >> directory;

            while (ss >> file) {
                size_t open_paren = file.find('(');
                std::string file_name = file.substr(0, open_paren);
                std::string content = file.substr(open_paren + 1, file.length() - open_paren - 2);
                contentMap[content].push_back(directory + "/" + file_name);
            }
        }

        std::vector<std::vector<std::string>> result;
        for (auto const& [content, file_paths] : contentMap) {
            if (file_paths.size() > 1) {
                result.push_back(file_paths);
            }
        }

        return result;
    }
};