#include <iostream>
#include <vector>
#include <string>
#include <map>

using namespace std;

class Solution {
public:
    class Calculator {
    public:
        Calculator(int value) : value_(value) {}

        Calculator add(int num) {
            value_ += num;
            return *this;
        }

        Calculator subtract(int num) {
            value_ -= num;
            return *this;
        }

        Calculator multiply(int num) {
            value_ *= num;
            return *this;
        }

        int getResult() {
            return value_;
        }

    private:
        int value_;
    };

    static Calculator create(int value) {
        return Calculator(value);
    }
};