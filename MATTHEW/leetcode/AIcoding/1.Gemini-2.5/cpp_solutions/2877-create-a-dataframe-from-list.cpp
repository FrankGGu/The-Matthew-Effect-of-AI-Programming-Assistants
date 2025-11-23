#include <vector>
#include <string>
#include <algorithm>

class Solution {
public:
    std::vector<std::vector<std::string>> createDataFrame(std::vector<std::vector<int>>& data, std::vector<std::string>& columns) {
        std::vector<std::vector<std::string>> result;

        result.push_back(columns);

        for (const auto& row : data) {
            std::vector<std::string> string_row;
            for (int val : row) {
                string_row.push_back(std::to_string(val));
            }
            result.push_back(string_row);
        }

        return result;
    }
};