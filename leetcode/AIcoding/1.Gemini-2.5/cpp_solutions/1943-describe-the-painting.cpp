#include <vector>
#include <map>
#include <algorithm>

class Solution {
public:
    std::vector<std::vector<long long>> describeThePainting(std::vector<std::vector<int>>& paintings) {
        std::map<int, long long> color_changes;

        for (const auto& p : paintings) {
            int start = p[0];
            int end = p[1];
            long long color = p[2];
            color_changes[start] += color;
            color_changes[end] -= color;
        }

        std::vector<std::vector<long long>> elementary_segments;
        long long current_color_sum = 0;
        int prev_point = -1;

        for (const auto& entry : color_changes) {
            int point = entry.first;
            long long change = entry.second;

            if (prev_point != -1 && point > prev_point) {
                if (current_color_sum > 0) {
                    elementary_segments.push_back({(long long)prev_point, (long long)point, current_color_sum});
                }
            }
            current_color_sum += change;
            prev_point = point;
        }

        std::vector<std::vector<long long>> result;
        if (elementary_segments.empty()) {
            return result;
        }

        std::vector<long long> current_merged_segment = elementary_segments[0];

        for (size_t i = 1; i < elementary_segments.size(); ++i) {
            const auto& seg = elementary_segments[i];
            if (seg[0] == current_merged_segment[1] && seg[2] == current_merged_segment[2]) {
                current_merged_segment[1] = seg[1];
            } else {
                result.push_back(current_merged_segment);
                current_merged_segment = seg;
            }
        }
        result.push_back(current_merged_segment);

        return result;
    }
};