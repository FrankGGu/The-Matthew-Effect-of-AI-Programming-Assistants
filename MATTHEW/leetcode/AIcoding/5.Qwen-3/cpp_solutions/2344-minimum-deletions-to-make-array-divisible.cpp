#include <iostream>
#include <vector>
#include <algorithm>
#include <numeric>
#include <unordered_set>

using namespace std;

class Solution {
public:
    int minDeletions(vector<int>& nums, vector<int>& divisors) {
        int n = nums.size();
        int m = divisors.size();

        for (int i = 0; i < m; ++i) {
            for (int j = i + 1; j < m; ++j) {
                if (divisors[i] % divisors[j] == 0) {
                    divisors.erase(divisors.begin() + i);
                    --i;
                    --m;
                    break;
                }
            }
        }

        int gcd_val = 0;
        for (int d : divisors) {
            gcd_val = gcd(gcd_val, d);
        }

        int count = 0;
        for (int num : nums) {
            if (num % gcd_val != 0) {
                ++count;
            }
        }

        return count;
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