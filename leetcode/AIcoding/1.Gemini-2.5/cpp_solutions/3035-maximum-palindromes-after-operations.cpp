#include <vector>
#include <string>
#include <numeric>
#include <algorithm>

class Solution {
public:
    int maxPalindromesAfterOperations(std::vector<std::string>& words) {
        std::vector<int> counts(26, 0);
        std::vector<int> lengths;
        for (const auto& word : words) {
            lengths.push_back(word.length());
            for (char c : word) {
                counts[c - 'a']++;
            }
        }

        int total_pairs = 0;
        int total_singles = 0;
        for (int count : counts) {
            total_pairs += count / 2;
            total_singles += count % 2;
        }

        std::sort(lengths.begin(), lengths.end());

        int ans = 0;
        for (int len : lengths) {
            int pairs_needed = len / 2;

            if (total_pairs < pairs_needed) {
                break;
            }
            total_pairs -= pairs_needed;

            if (len % 2 == 1) {
                if (total_singles > 0) {
                    total_singles--;
                } else if (total_pairs > 0) {
                    total_pairs--;
                    total_singles++;
                } else {
                    break;
                }
            }

            ans++;
        }

        return ans;
    }
};