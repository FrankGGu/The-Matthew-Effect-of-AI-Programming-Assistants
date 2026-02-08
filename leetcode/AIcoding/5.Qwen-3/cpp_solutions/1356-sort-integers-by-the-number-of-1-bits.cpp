#include <iostream>
#include <vector>
#include <algorithm>

class Solution {
public:
    static int countOnes(int n) {
        int count = 0;
        while (n) {
            count += n & 1;
            n >>= 1;
        }
        return count;
    }

    static bool compare(int a, int b) {
        int countA = countOnes(a);
        int countB = countOnes(b);
        if (countA == countB) {
            return a < b;
        }
        return countA < countB;
    }

    std::vector<int> sortJumbled(std::vector<int>& arr) {
        std::sort(arr.begin(), arr.end(), compare);
        return arr;
    }
};