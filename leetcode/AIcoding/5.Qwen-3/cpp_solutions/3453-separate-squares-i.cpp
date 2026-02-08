#include <iostream>
#include <vector>
#include <unordered_set>

using namespace std;

class Solution {
public:
    vector<int> squareDigits(int n) {
        vector<int> result;
        while (n > 0) {
            int digit = n % 10;
            result.push_back(digit * digit);
            n /= 10;
        }
        return result;
    }
};