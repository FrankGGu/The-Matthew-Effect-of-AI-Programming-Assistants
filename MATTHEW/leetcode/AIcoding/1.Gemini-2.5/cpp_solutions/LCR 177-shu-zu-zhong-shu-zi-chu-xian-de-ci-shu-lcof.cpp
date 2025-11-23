#include <vector>
#include <unordered_map>

class Solution {
public:
    long long colorClashMatching(std::vector<int>& colors) {
        std::unordered_map<int, int> counts;
        for (int color : colors) {
            counts[color]++;
        }

        long long n = colors.size();

        long long total_pairs = n * (n - 1) / 2;

        long long same_color_pairs = 0;
        for (auto const& pair : counts) {
            long long count = pair.second;
            same_color_pairs += count * (count - 1) / 2;
        }

        return total_pairs - same_color_pairs;
    }
};