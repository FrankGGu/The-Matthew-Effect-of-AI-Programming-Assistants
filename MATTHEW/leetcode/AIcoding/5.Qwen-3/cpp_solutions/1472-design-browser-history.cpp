#include <iostream>
#include <vector>
#include <string>

using namespace std;

class Solution {
private:
    vector<string> history;
    int current;

public:
    Solution(string homepage) {
        history.push_back(homepage);
        current = 0;
    }

    void visit(string url) {
        while (history.size() > current + 1) {
            history.pop_back();
        }
        history.push_back(url);
        current++;
    }

    string back(int steps) {
        int newCurrent = current - steps;
        if (newCurrent < 0) {
            newCurrent = 0;
        }
        current = newCurrent;
        return history[current];
    }

    string forward(int steps) {
        int newCurrent = current + steps;
        if (newCurrent >= history.size()) {
            newCurrent = history.size() - 1;
        }
        current = newCurrent;
        return history[current];
    }
};