#include <vector>
#include <string>
#include <map>

class Product {
public:
    int product_id;
    int price;
    std::vector<std::string> sale_dates;
};

class Solution {
public:
    std::map<std::string, long long> seasonalSalesAnalysis(const std::vector<Product>& products) {
        std::map<std::string, long long> seasonalRevenue = {
            {"Spring", 0LL},
            {"Summer", 0LL},
            {"Fall", 0LL},
            {"Winter", 0LL}
        };

        for (const auto& product : products) {
            for (const auto& date : product.sale_dates) {
                if (date.length() < 7) {
                    continue;
                }

                int month = std::stoi(date.substr(5, 2));

                if (month >= 3 && month <= 5) {
                    seasonalRevenue["Spring"] += product.price;
                } else if (month >= 6 && month <= 8) {
                    seasonalRevenue["Summer"] += product.price;
                } else if (month >= 9 && month <= 11) {
                    seasonalRevenue["Fall"] += product.price;
                } else {
                    seasonalRevenue["Winter"] += product.price;
                }
            }
        }

        return seasonalRevenue;
    }
};