#include <iostream>
#include <vector>
#include <cmath>

using namespace std;

class Solution {
public:
    int sumOfDivisors(int n) {
        int sum = 0;
        int count = 0;
        for (int i = 1; i <= sqrt(n); ++i) {
            if (n % i == 0) {
                if (i * i == n) {
                    count++;
                    sum += i;
                } else {
                    count += 2;
                    sum += i + n / i;
                }
            }
        }
        return count == 4 ? sum : 0;
    }

    int fourDivisors(int n) {
        int total = 0;
        for (int i = 1; i <= n; ++i) {
            total += sumOfDivisors(i);
        }
        return total;
    }
};