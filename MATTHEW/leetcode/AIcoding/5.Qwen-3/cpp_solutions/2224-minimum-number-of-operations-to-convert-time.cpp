#include <iostream>
#include <vector>
#include <string>

using namespace std;

class Solution {
public:
    int convertTime(string current, string correct) {
        int currMin = stoi(current.substr(0, 2)) * 60 + stoi(current.substr(3, 2));
        int corrMin = stoi(correct.substr(0, 2)) * 60 + stoi(correct.substr(3, 2));

        int diff = corrMin - currMin;
        int count = 0;

        vector<int> denominations = {60, 15, 5, 1};

        for (int denom : denominations) {
            if (diff >= denom) {
                count += diff / denom;
                diff %= denom;
            }
        }

        return count;
    }
};