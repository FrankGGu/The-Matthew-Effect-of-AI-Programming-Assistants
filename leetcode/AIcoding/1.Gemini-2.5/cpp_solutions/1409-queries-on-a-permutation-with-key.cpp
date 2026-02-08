#include <vector>
#include <numeric>
#include <algorithm>

class Solution {
public:
    std::vector<int> processQueries(std::vector<int>& queries, int m) {
        std::vector<int> p(m);
        std::iota(p.begin(), p.end(), 1);

        std::vector<int> results;
        results.reserve(queries.size());

        for (int query_val : queries) {
            auto it = std::find(p.begin(), p.end(), query_val);
            int position = std::distance(p.begin(), it);
            results.push_back(position);

            int value_to_move = *it;
            p.erase(it);
            p.insert(p.begin(), value_to_move);
        }

        return results;
    }
};