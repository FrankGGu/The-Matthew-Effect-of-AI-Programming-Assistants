#include <vector>
#include <stack>

using namespace std;

vector<int> dailyTemperatures(vector<int>& T) {
    int n = T.size();
    vector<int> result(n, 0);
    stack<int> stk;

    for (int i = 0; i < n; ++i) {
        while (!stk.empty() && T[i] > T[stk.top()]) {
            int idx = stk.top();
            stk.pop();
            result[idx] = i - idx;
        }
        stk.push(i);
    }

    return result;
}