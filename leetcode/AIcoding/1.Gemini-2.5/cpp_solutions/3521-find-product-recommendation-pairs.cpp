#include <vector>
#include <map>
#include <set>
#include <algorithm>
#include <utility>

class Solution {
public:
    std::vector<std::vector<int>> findRecommendationPairs(std::vector<std::pair<int, int>>& purchases) {
        std::map<int, std::set<int>> userProducts;
        for (const auto& purchase : purchases) {
            userProducts[purchase.first].insert(purchase.second);
        }

        std::map<std::pair<int, int>, int> pairCounts;
        for (const auto& entry : userProducts) {
            const std::set<int>& products = entry.second;
            if (products.size() < 2) {
                continue;
            }

            std::vector<int> currentProducts(products.begin(), products.end());

            for (size_t i = 0; i < currentProducts.size(); ++i) {
                for (size_t j = i + 1; j < currentProducts.size(); ++j) {
                    pairCounts[{currentProducts[i], currentProducts[j]}]++;
                }
            }
        }

        std::vector<std::vector<int>> result;
        for (const auto& entry : pairCounts) {
            result.push_back({entry.first.first, entry.first.second, entry.second});
        }

        std::sort(result.begin(), result.end(), [](const std::vector<int>& a, const std::vector<int>& b) {
            if (a[2] != b[2]) {
                return a[2] > b[2];
            }
            if (a[0] != b[0]) {
                return a[0] < b[0];
            }
            return a[1] < b[1];
        });

        return result;
    }
};