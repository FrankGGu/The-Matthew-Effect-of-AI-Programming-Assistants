#include <vector>
#include <unordered_set>
#include <algorithm>

class Solution {
public:
    int reverse(int n) {
        int reversed_n = 0;
        while (n > 0) {
            int digit = n % 10;
            reversed_n = reversed_n * 10 + digit;
            n /= 10;
        }
        return reversed_n;
    }

    int countDistinctIntegers(std::vector<int>& nums) {
        std::unordered_set<int> distinct_numbers;
        for (int num : nums) {
            distinct_numbers.insert(num);
            distinct_numbers.insert(reverse(num));
        }
        return distinct_numbers.size();
    }
};