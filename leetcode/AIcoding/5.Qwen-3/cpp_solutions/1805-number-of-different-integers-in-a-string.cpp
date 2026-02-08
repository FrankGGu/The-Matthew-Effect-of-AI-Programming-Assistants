#include <iostream>
#include <vector>
#include <string>
#include <unordered_set>

using namespace std;

class Solution {
public:
    int numberOfDifferentIntegers(const string& word) {
        unordered_set<string> numbers;
        string currentNumber = "";
        bool isDigit = false;

        for (char c : word) {
            if (isdigit(c)) {
                currentNumber += c;
                isDigit = true;
            } else {
                if (isDigit) {
                    numbers.insert(currentNumber);
                    currentNumber = "";
                    isDigit = false;
                }
            }
        }

        if (isDigit) {
            numbers.insert(currentNumber);
        }

        return numbers.size();
    }
};