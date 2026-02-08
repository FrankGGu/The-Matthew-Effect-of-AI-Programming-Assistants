#include <vector>
#include <unordered_map>
#include <map>
#include <set>
#include <algorithm>
#include <utility>

class Solution {
public:
    std::vector<std::vector<int>> findCategoryRecommendationPairs(std::vector<std::vector<int>>& purchases) {
        std::unordered_map<int, std::set<int>> user_to_categories;
        for (const auto& purchase : purchases) {
            int user_id = purchase[0];
            int category_id = purchase[1];
            user_to_categories[user_id].insert(category_id);
        }

        std::map<std::pair<int, int>, int> pair_counts;
        for (const auto& entry : user_to_categories) {
            const auto& categories = entry.second;
            if (categories.size() < 2) {
                continue;
            }

            for (auto it1 = categories.begin(); it1 != categories.end(); ++it1) {
                for (auto it2 = std::next(it1); it2 != categories.end(); ++it2) {
                    pair_counts[{*it1, *it2}]++;
                }
            }
        }

        std::vector<std::vector<int>> result;
        for (const auto& entry : pair_counts) {
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