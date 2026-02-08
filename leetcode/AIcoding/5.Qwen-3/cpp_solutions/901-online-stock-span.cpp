#include <iostream>
#include <vector>
#include <stack>

using namespace std;

class Solution {
private:
    stack<pair<int, int>> stockStack;
    int day;

public:
    Solution() : day(0) {}

    int next(int price) {
        int span = 1;
        while (!stockStack.empty() && stockStack.top().first <= price) {
            span += stockStack.top().second;
            stockStack.pop();
        }
        stockStack.push({price, span});
        day++;
        return span;
    }
};