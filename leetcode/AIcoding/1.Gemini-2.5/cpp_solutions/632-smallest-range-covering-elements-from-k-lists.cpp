#include <vector>
#include <queue>
#include <limits>
#include <algorithm>

struct Element {
    int val;
    int list_idx;
    int elem_idx;

    bool operator>(const Element& other) const {
        return val > other.val;
    }
};

class Solution {
public:
    std::vector<int> smallestRange(std::vector<std::vector<int>>& nums) {
        int k = nums.size();
        std::priority_queue<Element, std::vector<Element>, std::greater<Element>> pq;

        int max_val = std::numeric_limits<int>::min();

        for (int i = 0; i < k; ++i) {
            pq.push({nums[i][0], i, 0});
            max_val = std::max(max_val, nums[i][0]);
        }

        int range_start = 0;
        int range_end = 0;
        int min_range_diff = std::numeric_limits<int>::max();

        while (true) {
            Element min_elem = pq.top();
            pq.pop();

            int current_min_val = min_elem.val;

            if (max_val - current_min_val < min_range_diff) {
                min_range_diff = max_val - current_min_val;
                range_start = current_min_val;
                range_end = max_val;
            }

            if (min_elem.elem_idx + 1 < nums[min_elem.list_idx].size()) {
                int next_val = nums[min_elem.list_idx][min_elem.elem_idx + 1];
                pq.push({next_val, min_elem.list_idx, min_elem.elem_idx + 1});
                max_val = std::max(max_val, next_val);
            } else {
                break;
            }
        }

        return {range_start, range_end};
    }
};