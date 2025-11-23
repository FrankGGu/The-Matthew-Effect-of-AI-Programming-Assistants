#include <vector>
#include <unordered_set>
#include <algorithm>
#include <cmath>

class Solution {
public:
    int longestSquareStreak(std::vector<int>& nums) {
        std::unordered_set<int> s(nums.begin(), nums.end());
        int maxLength = 0;

        for (int num : s) {
            long long root = static_cast<long long>(sqrt(num));
            if (root * root == num && s.count(root)) {
                continue;
            }

            int currentLength = 0;
            long long currentNum = num;
            while (s.count(currentNum)) {
                currentLength++;
                if (currentNum > 31622) { 
                    break;
                }
                currentNum *= currentNum;
            }
            maxLength = std::max(maxLength, currentLength);
        }

        return maxLength >= 2 ? maxLength : -1;
    }
};