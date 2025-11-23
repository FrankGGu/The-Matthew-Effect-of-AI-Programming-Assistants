#include <vector>
#include <numeric>
#include <algorithm>

class Solution {
public:
    long long dividePlayers(std::vector<int>& skill) {
        int n = skill.size();
        std::sort(skill.begin(), skill.end());

        long long chemistry_sum = 0;
        int target_sum = skill[0] + skill[n - 1];

        int left = 0;
        int right = n - 1;

        while (left < right) {
            if (skill[left] + skill[right] != target_sum) {
                return -1;
            }
            chemistry_sum += (long long)skill[left] * skill[right];
            left++;
            right--;
        }

        return chemistry_sum;
    }
};