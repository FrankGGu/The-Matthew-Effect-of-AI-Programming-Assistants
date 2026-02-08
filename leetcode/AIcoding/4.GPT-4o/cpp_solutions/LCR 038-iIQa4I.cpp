#include <vector>
#include <stack>

using namespace std;

vector<int> dailyTemperatures(vector<int>& T) {
    int n = T.size();
    vector<int> res(n, 0);
    stack<int> s;

    for (int i = 0; i < n; i++) {
        while (!s.empty() && T[i] > T[s.top()]) {
            int idx = s.top();
            s.pop();
            res[idx] = i - idx;
        }
        s.push(i);
    }

    return res;
}