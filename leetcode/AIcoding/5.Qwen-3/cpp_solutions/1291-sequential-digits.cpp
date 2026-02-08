#include <iostream>
#include <vector>
#include <algorithm>

class Solution {
public:
    std::vector<int> sequentialDigits(int n) {
        std::vector<int> result;
        for (int length = 1; length <= 10; ++length) {
            for (int start = 1; start <= 10 - length; ++start) {
                int num = 0;
                for (int i = 0; i < length; ++i) {
                    num = num * 10 + (start + i);
                }
                if (num <= n) {
                    result.push_back(num);
                }
            }
        }
        std::sort(result.begin(), result.end());
        return result;
    }
};