#include <vector>
#include <stack>

using namespace std;

vector<int> asteroidCollision(vector<int>& asteroids) {
    stack<int> stk;
    for (int asteroid : asteroids) {
        bool destroyed = false;
        while (!stk.empty() && asteroid < 0 && stk.top() > 0) {
            if (stk.top() < -asteroid) {
                stk.pop();
                continue;
            } else if (stk.top() == -asteroid) {
                stk.pop();
            }
            destroyed = true;
            break;
        }
        if (!destroyed) {
            stk.push(asteroid);
        }
    }
    vector<int> result;
    while (!stk.empty()) {
        result.push_back(stk.top());
        stk.pop();
    }
    reverse(result.begin(), result.end());
    return result;
}