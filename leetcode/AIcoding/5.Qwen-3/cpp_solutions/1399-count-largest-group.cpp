#include <iostream>
#include <vector>
#include <unordered_map>

using namespace std;

class Solution {
public:
    int countLargestGroup(int n) {
        unordered_map<int, int> groupCount;
        for (int i = 1; i <= n; ++i) {
            int sum = 0;
            int num = i;
            while (num > 0) {
                sum += num % 10;
                num /= 10;
            }
            groupCount[sum]++;
        }

        int max_size = 0;
        for (const auto& pair : groupCount) {
            if (pair.second > max_size) {
                max_size = pair.second;
            }
        }

        int result = 0;
        for (const auto& pair : groupCount) {
            if (pair.second == max_size) {
                ++result;
            }
        }

        return result;
    }
};