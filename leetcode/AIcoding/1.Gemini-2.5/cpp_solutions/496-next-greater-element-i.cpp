#include <vector>
#include <stack>
#include <unordered_map>

class Solution {
public:
    std::vector<int> nextGreaterElement(std::vector<int>& nums1, std::vector<int>& nums2) {
        std::unordered_map<int, int> next_greater_map;
        std::stack<int> s;

        for (int num : nums2) {
            while (!s.empty() && s.top() < num) {
                next_greater_map[s.top()] = num;
                s.pop();
            }
            s.push(num);
        }

        std::vector<int> result;
        result.reserve(nums1.size());
        for (int num : nums1) {
            if (next_greater_map.count(num)) {
                result.push_back(next_greater_map[num]);
            } else {
                result.push_back(-1);
            }
        }

        return result;
    }
};