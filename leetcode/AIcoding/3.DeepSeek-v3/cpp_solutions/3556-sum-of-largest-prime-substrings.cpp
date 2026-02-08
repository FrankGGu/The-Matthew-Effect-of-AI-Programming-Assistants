#include <vector>
#include <algorithm>
#include <cmath>

using namespace std;

class Solution {
private:
    bool isPrime(int num) {
        if (num <= 1) return false;
        if (num == 2) return true;
        if (num % 2 == 0) return false;
        for (int i = 3; i * i <= num; i += 2) {
            if (num % i == 0) return false;
        }
        return true;
    }

public:
    int sumLargestPrimeSubstrings(string s) {
        int max_sum = 0;
        int n = s.size();
        for (int i = 0; i < n; ++i) {
            for (int j = i; j < n; ++j) {
                string substring = s.substr(i, j - i + 1);
                int num = stoi(substring);
                if (isPrime(num)) {
                    max_sum = max(max_sum, num);
                }
            }
        }
        return max_sum;
    }
};