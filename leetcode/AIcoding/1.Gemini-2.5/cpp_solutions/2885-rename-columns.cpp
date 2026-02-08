#include <vector>
#include <string>
#include <map>

class Solution {
public:
    std::vector<std::map<std::string, std::string>> renameColumns(
        std::vector<std::map<std::string, std::string>> data,
        const std::map<std::string, std::string>& rename_map) {

        std::vector<std::map<std::string, std::string>> result;
        for (const auto& row : data) {
            std::map<std::string, std::string> new_row;
            for (const auto& pair : row) {
                const std::string& old_col_name = pair.first;
                const std::string& value = pair.second;

                auto it = rename_map.find(old_col_name);
                if (it != rename_map.end()) {
                    new_row[it->second] = value;
                } else {
                    new_row[old_col_name] = value;
                }
            }
            result.push_back(new_row);
        }
        return result;
    }
};