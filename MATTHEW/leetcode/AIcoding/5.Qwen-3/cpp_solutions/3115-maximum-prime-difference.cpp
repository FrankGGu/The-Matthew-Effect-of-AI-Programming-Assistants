#include <iostream>
#include <vector>
#include <cmath>

using namespace std;

class Solution {
public:
    int maxPrimeDifference(vector<int>& nums) {
        auto isPrime = [](int n) {
            if (n < 2) return false;
            for (int i = 2; i <= sqrt(n); ++i) {
                if (n % i == 0) return false;
            }
            return true;
        };

        int maxPrime = -1;
        int minPrime = -1;

        for (int num : nums) {
            if (isPrime(num)) {
                if (maxPrime == -1 || num > maxPrime) {
                    maxPrime = num;
                }
                if (minPrime == -1 || num < minPrime) {
                    minPrime = num;
                }
            }
        }

        return maxPrime - minPrime;
    }
};