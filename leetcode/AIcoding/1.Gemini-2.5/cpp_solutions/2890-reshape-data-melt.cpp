#include <vector>
#include <string>

class Solution {
public:
    std::vector<std::vector<std::string>> melt(std::vector<std::vector<std::string>>& data) {
        std::vector<std::vector<std::string>> melted_data;

        melted_data.push_back({"id", "variable", "value"});

        if (data.empty() || data[0].empty() || data.size() <= 1 || data[0].size() <= 1) {
            return melted_data;
        }

        int num_rows = data.size();
        int num_cols = data[0].size();

        for (int i = 1; i < num_rows; ++i) {
            std::string id_value = data[i][0];

            for (int j = 1; j < num_cols; ++j) {
                std::string variable_name = data[0][j];
                std::string value = data[i][j];
                melted_data.push_back({id_value, variable_name, value});
            }
        }

        return melted_data;
    }
};