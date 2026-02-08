#include <iostream>
#include <string>

using namespace std;

class Solution {
public:
    int reverseInteger(int num) {
        int reversed = 0;
        while (num > 0) {
            reversed = reversed * 10 + num % 10;
            num /= 10;
        }
        return reversed;
    }

    int numberAfterDoubleReversal(int num) {
        int firstReverse = reverseInteger(num);
        int secondReverse = reverseInteger(firstReverse);
        return secondReverse;
    }
};