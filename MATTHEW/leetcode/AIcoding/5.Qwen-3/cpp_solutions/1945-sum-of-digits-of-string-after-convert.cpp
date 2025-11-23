#include <iostream>
#include <string>
#include <vector>

using namespace std;

class Solution {
public:
    int sumDigits(string s) {
        int sum = 0;
        for (char c : s) {
            sum += (c - 'a' + 1);
        }
        return sum;
    }

    int getLucky(string s, int k) {
        string numStr;
        for (char c : s) {
            numStr += to_string(c - 'a' + 1);
        }

        int currentSum = 0;
        for (char c : numStr) {
            currentSum += c - '0';
        }

        for (int i = 1; i < k; ++i) {
            int newSum = 0;
            while (currentSum > 0) {
                newSum += currentSum % 10;
                currentSum /= 10;
            }
            currentSum = newSum;
        }

        return currentSum;
    }
};