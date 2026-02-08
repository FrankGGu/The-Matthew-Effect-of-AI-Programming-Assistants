#include <vector>
#include <algorithm>
#include <utility>

class Solution {
public:
    std::vector<int> mostBeautifulItem(std::vector<std::vector<int>>& items, std::vector<std::vector<int>>& queries) {
        std::sort(items.begin(), items.end());

        int current_max_beauty = 0;
        for (int i = 0; i < items.size(); ++i) {
            current_max_beauty = std::max(current_max_beauty, items[i][1]);
            items[i][1] = current_max_beauty;
        }

        std::vector<std::pair<int, int>> sorted_queries(queries.size());
        for (int i = 0; i < queries.size(); ++i) {
            sorted_queries[i] = {queries[i][0], i};
        }

        std::sort(sorted_queries.begin(), sorted_queries.end());

        std::vector<int> ans(queries.size());
        int item_ptr = 0;

        for (const auto& query_pair : sorted_queries) {
            int current_max_price = query_pair.first;
            int original_query_index = query_pair.second;

            while (item_ptr < items.size() && items[item_ptr][0] <= current_max_price) {
                item_ptr++;
            }

            if (item_ptr > 0) {
                ans[original_query_index] = items[item_ptr - 1][1];
            } else {
                ans[original_query_index] = 0;
            }
        }

        return ans;
    }
};