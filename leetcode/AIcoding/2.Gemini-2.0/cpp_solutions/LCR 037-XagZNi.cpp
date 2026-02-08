#include <vector>
#include <stack>

using namespace std;

class Solution {
public:
    vector<int> asteroidCollision(vector<int>& asteroids) {
        stack<int> s;
        for (int asteroid : asteroids) {
            bool alive = true;
            while (!s.empty() && asteroid < 0 && s.top() > 0) {
                if (s.top() < -asteroid) {
                    s.pop();
                } else if (s.top() == -asteroid) {
                    s.pop();
                    alive = false;
                    break;
                } else {
                    alive = false;
                    break;
                }
            }
            if (alive) {
                s.push(asteroid);
            }
        }

        vector<int> result(s.size());
        vector<int>::reverse_iterator it = result.rbegin();
        while (!s.empty()) {
            *it = s.top();
            s.pop();
            it++;
        }

        return result;
    }
};