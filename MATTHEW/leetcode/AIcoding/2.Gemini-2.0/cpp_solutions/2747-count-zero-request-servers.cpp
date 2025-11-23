#include <vector>
#include <numeric>

class Solution {
public:
    std::vector<int> countServers(int n, std::vector<std::vector<int>>& logs, int x, std::vector<int>& queries) {
        std::vector<int> result(queries.size());
        for (size_t i = 0; i < queries.size(); ++i) {
            int timestamp = queries[i];
            int count = 0;
            for (int j = 0; j < n; ++j) {
                bool active = false;
                for (const auto& log : logs) {
                    if (log[0] == j && timestamp - log[1] < x) {
                        active = true;
                        break;
                    }
                }
                if (active) {
                    count++;
                }
            }
            result[i] = count;
        }
        return result;
    }
};