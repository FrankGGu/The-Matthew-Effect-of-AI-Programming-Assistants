#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int sumOfEncryptedInt(vector<int>& nums) {
        int total = 0;
        for (int num : nums) {
            total += encrypt(num);
        }
        return total;
    }

private:
    int encrypt(int num) {
        int maxDigit = 0;
        int digits = 0;
        while (num > 0) {
            int digit = num % 10;
            maxDigit = max(maxDigit, digit);
            num /= 10;
            digits++;
        }
        int encrypted = 0;
        for (int i = 0; i < digits; i++) {
            encrypted = encrypted * 10 + maxDigit;
        }
        return encrypted;
    }
};