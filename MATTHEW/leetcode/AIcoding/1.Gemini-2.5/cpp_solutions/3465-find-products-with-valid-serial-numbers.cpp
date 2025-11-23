#include <vector>
#include <string>
#include <cctype>

class Solution {
public:
    std::vector<std::vector<std::string>> findValidProducts(std::vector<std::vector<std::string>>& products) {
        std::vector<std::vector<std::string>> validProducts;

        for (const auto& product : products) {
            if (product.size() < 2) {
                continue;
            }

            const std::string& serialNumber = product[1]; // Assuming serial number is at index 1

            // Placeholder validation logic:
            // A serial number is considered "valid" if it contains at least one digit.
            // This specific rule is a generic example as the actual problem description is missing.
            bool isValid = false;
            for (char c : serialNumber) {
                if (std::isdigit(c)) {
                    isValid = true;
                    break;
                }
            }

            if (isValid) {
                validProducts.push_back(product);
            }
        }

        return validProducts;
    }
};