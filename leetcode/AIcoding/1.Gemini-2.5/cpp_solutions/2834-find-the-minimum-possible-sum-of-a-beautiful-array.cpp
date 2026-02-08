#include <vector>
#include <numeric>
#include <unordered_set>

class Solution {
public:
    long long minimumPossibleSum(int n, int target) {
        long long current_sum = 0;
        std::unordered_set<int> picked_numbers;
        int count = 0;
        int current_num = 1;

        while (count < n) {
            if (picked_numbers.find(target - current_num) == picked_numbers.end()) {
                current_sum += current_num;
                picked_numbers.insert(current_num);
                count++;
            }
            current_num++;
        }

        return current_sum;
    }
};