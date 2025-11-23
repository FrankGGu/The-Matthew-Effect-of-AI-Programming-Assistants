#include <stack>
#include <utility>

class StockSpanner {
private:
    std::stack<std::pair<int, int>> s; // Stores {price, span}
public:
    StockSpanner() {

    }

    int next(int price) {
        int span = 1;
        while (!s.empty() && s.top().first <= price) {
            span += s.top().second;
            s.pop();
        }
        s.push({price, span});
        return span;
    }
};