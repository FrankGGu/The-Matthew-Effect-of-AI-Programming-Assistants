#include <vector>

using namespace std;

class Solution {
public:
    vector<int> asteroidCollision(vector<int>& asteroids) {
        vector<int> stack;
        for (int ast : asteroids) {
            bool alive = true;
            while (alive && ast < 0 && !stack.empty() && stack.back() > 0) {
                if (stack.back() < -ast) {
                    stack.pop_back();
                } else if (stack.back() == -ast) {
                    stack.pop_back();
                    alive = false;
                } else {
                    alive = false;
                }
            }
            if (alive) {
                stack.push_back(ast);
            }
        }
        return stack;
    }
};