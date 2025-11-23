#include <iostream>
#include <vector>
#include <cmath>

using namespace std;

class Solution {
public:
    int sumOfPrimeFactors(int n) {
        int sum = 0;
        for (int i = 2; i <= sqrt(n); ++i) {
            while (n % i == 0) {
                sum += i;
                n /= i;
            }
        }
        if (n > 1) {
            sum += n;
        }
        return sum;
    }

    int smallestValue(int n) {
        int current = n;
        while (true) {
            int next = sumOfPrimeFactors(current);
            if (next == current) {
                break;
            }
            current = next;
        }
        return current;
    }
};