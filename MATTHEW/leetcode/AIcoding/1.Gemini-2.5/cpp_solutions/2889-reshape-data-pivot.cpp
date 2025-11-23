#include <vector>
#include <string>

class Solution {
public:
    std::vector<std::vector<std::string>> pivotTable(std::vector<std::vector<std::string>>& products) {
        std::vector<std::vector<std::string>> result;
        std::vector<std::string> store_names = {"store1", "store2", "store3"};

        for (const auto& product_row : products) {
            std::string product_id = product_row[0];
            for (int i = 0; i < 3; ++i) {
                std::string price_str = product_row[i + 1];
                if (price_str != "null") {
                    std::vector<std::string> new_row;
                    new_row.push_back(product_id);
                    new_row.push_back(store_names[i]);
                    new_row.push_back(price_str);
                    result.push_back(new_row);
                }
            }
        }
        return result;
    }
};