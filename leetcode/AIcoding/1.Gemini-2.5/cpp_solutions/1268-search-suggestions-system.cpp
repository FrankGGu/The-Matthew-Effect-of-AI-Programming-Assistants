#include <vector>
#include <string>
#include <algorithm> // For std::sort

class Solution {
public:
    std::vector<std::vector<std::string>> suggestedProducts(std::vector<std::string>& products, std::string searchWord) {
        std::sort(products.begin(), products.end());

        std::vector<std::vector<std::string>> result;
        std::string current_prefix = "";

        int left = 0;
        int right = products.size() - 1;

        for (char c : searchWord) {
            current_prefix += c;

            // Adjust left pointer: find the first product in the current range
            // that starts with current_prefix.
            while (left <= right && 
                   (products[left].length() < current_prefix.length() || 
                    products[left].compare(0, current_prefix.length(), current_prefix) != 0)) {
                left++;
            }

            // Adjust right pointer: find the last product in the current range
            // that starts with current_prefix.
            while (left <= right && 
                   (products[right].length() < current_prefix.length() || 
                    products[right].compare(0, current_prefix.length(), current_prefix) != 0)) {
                right--;
            }

            // Collect up to 3 suggestions from the valid range [left, right]
            std::vector<std::string> suggestions_for_prefix;
            for (int i = 0; i < 3 && left + i <= right; ++i) {
                suggestions_for_prefix.push_back(products[left + i]);
            }
            result.push_back(suggestions_for_prefix);
        }
        return result;
    }
};