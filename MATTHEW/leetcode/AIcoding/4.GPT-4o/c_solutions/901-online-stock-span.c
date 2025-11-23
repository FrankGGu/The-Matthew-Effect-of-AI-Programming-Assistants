#include <stack>

struct StockSpanner {
    std::stack<std::pair<int, int>> stk;
    int day;

    StockSpanner() {
        day = 0;
    }

    int next(int price) {
        day++;
        while (!stk.empty() && stk.top().first <= price) {
            stk.pop();
        }
        int span = stk.empty() ? day : day - stk.top().second;
        stk.push({price, day});
        return span;
    }
};