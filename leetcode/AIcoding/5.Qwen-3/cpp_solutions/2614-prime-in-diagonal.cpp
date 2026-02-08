#include <iostream>
#include <vector>

using namespace std;

class Solution {
public:
    int diagonalPrime(vector<vector<int>>& nums) {
        int maxPrime = 0;
        int n = nums.size();
        for (int i = 0; i < n; ++i) {
            int num = nums[i][i];
            if (isPrime(num) && num > maxPrime) {
                maxPrime = num;
            }
            num = nums[i][n - 1 - i];
            if (isPrime(num) && num > maxPrime) {
                maxPrime = num;
            }
        }
        return maxPrime;
    }

private:
    bool isPrime(int num) {
        if (num < 2) return false;
        for (int i = 2; i * i <= num; ++i) {
            if (num % i == 0) return false;
        }
        return true;
    }
};