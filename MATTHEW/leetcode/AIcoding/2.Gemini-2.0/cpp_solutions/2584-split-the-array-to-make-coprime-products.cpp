#include <vector>
#include <numeric>
#include <algorithm>

using namespace std;

class Solution {
public:
    int findValidSplit(vector<int>& nums) {
        int n = nums.size();
        vector<int> right(n, 1);
        vector<int> left(n, 1);

        vector<int> max_prime(n, 1);

        for (int i = 0; i < n; ++i) {
            int temp = nums[i];
            for (int j = 2; j * j <= temp; ++j) {
                if (temp % j == 0) {
                    max_prime[i] = max(max_prime[i], j);
                    while (temp % j == 0) {
                        temp /= j;
                    }
                }
            }
            if (temp > 1) {
                max_prime[i] = max(max_prime[i], temp);
            }
        }

        right[n - 1] = max_prime[n - 1];
        for (int i = n - 2; i >= 0; --i) {
            right[i] = max(right[i + 1], max_prime[i]);
        }

        left[0] = max_prime[0];
        for (int i = 1; i < n; ++i) {
            left[i] = max(left[i - 1], max_prime[i]);
        }

        for (int i = 0; i < n - 1; ++i) {
            if (gcd(left[i], right[i + 1]) == 1) {
                return i;
            }
        }

        return -1;
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