#include <iostream>
#include <vector>
#include <unordered_set>
#include <algorithm>

using namespace std;

class Solution {
public:
    int countDifferentSubsequenceGCDs(const vector<int>& nums) {
        unordered_set<int> numSet(nums.begin(), nums.end());
        int maxVal = *max_element(nums.begin(), nums.end());
        int result = 0;

        for (int g = 1; g <= maxVal; ++g) {
            int currentGCD = 0;
            for (int i = g; i <= maxVal; i += g) {
                if (numSet.count(i)) {
                    currentGCD = gcd(currentGCD, i);
                }
            }
            if (currentGCD == g) {
                ++result;
            }
        }
        return result;
    }

private:
    int gcd(int a, int b) {
        while (b) {
            int temp = b;
            b = a % b;
            a = temp;
        }
        return a;
    }
};