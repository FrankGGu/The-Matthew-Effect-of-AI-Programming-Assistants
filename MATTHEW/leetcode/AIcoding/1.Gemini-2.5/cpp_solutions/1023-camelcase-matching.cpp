#include <vector>
#include <string>
#include <cctype>

class Solution {
public:
    bool matches(const std::string& query, const std::string& pattern) {
        int q_idx = 0;
        int p_idx = 0;

        while (q_idx < query.length()) {
            if (p_idx < pattern.length() && query[q_idx] == pattern[p_idx]) {
                p_idx++;
                q_idx++;
            } else {
                if (std::isupper(query[q_idx])) {
                    return false;
                }
                q_idx++;
            }
        }

        return p_idx == pattern.length();
    }

    std::vector<bool> camelMatch(std::vector<std::string>& queries, std::string pattern) {
        std::vector<bool> results;
        results.reserve(queries.size());

        for (const std::string& query : queries) {
            results.push_back(matches(query, pattern));
        }

        return results;
    }
};