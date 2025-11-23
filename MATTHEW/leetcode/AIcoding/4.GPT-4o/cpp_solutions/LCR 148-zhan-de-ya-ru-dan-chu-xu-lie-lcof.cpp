#include <vector>
#include <stack>
#include <string>

using namespace std;

bool validateStackSequences(vector<int>& pushed, vector<int>& popped) {
    stack<int> stk;
    int j = 0;
    for (int x : pushed) {
        stk.push(x);
        while (!stk.empty() && stk.top() == popped[j]) {
            stk.pop();
            j++;
        }
    }
    return stk.empty();
}