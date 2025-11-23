#include <vector>
#include <string>
#include <algorithm>
#include <utility> // For std::pair

class Solution {
public:
    std::vector<int> smallestTrimmedNumbers(std::vector<std::string>& nums, std::vector<std::vector<int>>& queries) {
        std::vector<int> results;
        results.reserve(queries.size());

        for (const auto& query : queries) {
            int k = query[0];
            int trim = query[1];

            std::vector<std::pair<std::string, int>> trimmed_pairs;
            trimmed_pairs.reserve(nums.size());

            for (int i = 0; i < nums.size(); ++i) {
                const std::string& num_str = nums[i];
                int len = num_str.length();

                // Calculate the starting position for the substring.
                // If 'trim' is greater than the number's length, we take the entire string.
                // Otherwise, we take the rightmost 'trim' digits.
                size_t start_pos = (len > trim) ? (len - trim) : 0;

                // Extract the trimmed number string.
                // std::string::substr(pos) extracts from 'pos' to the end of the string.
                // This correctly handles cases where 'trim' is greater than 'len'.
                trimmed_pairs.emplace_back(num_str.substr(start_pos), i);
            }

            // Sort the pairs.
            // std::pair sorts first by the first element (trimmed string),
            // then by the second element (original index) for tie-breaking.
            std::sort(trimmed_pairs.begin(), trimmed_pairs.end());

            // The k-th smallest (1-indexed) is at index k-1 in the sorted vector.
            results.push_back(trimmed_pairs[k - 1].second);
        }

        return results;
    }
};