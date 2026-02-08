#include <iostream>
#include <vector>

using namespace std;

class Solution {
public:
    int findKthNumber(int n, int k) {
        long long number = 1;
        long long count = 0;
        while (count < k) {
            long long steps = 0;
            long long first = number;
            long long last = number + 1;
            while (first <= n) {
                steps += min(n + 1, last) - first;
                first *= 10;
                last *= 10;
            }
            if (count + steps < k) {
                count += steps;
                number++;
            } else {
                count++;
                number *= 10;
            }
        }
        return number;
    }
};