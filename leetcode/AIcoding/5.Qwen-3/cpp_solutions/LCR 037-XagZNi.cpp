#include <iostream>
#include <vector>
#include <stack>

using namespace std;

class Solution {
public:
    vector<int> asteroidCollision(vector<int>& asteroids) {
        stack<int> st;
        for (int ast : asteroids) {
            bool collide = true;
            while (!st.empty() && st.top() > 0 && ast < 0) {
                if (st.top() < -ast) {
                    st.pop();
                } else if (st.top() == -ast) {
                    st.pop();
                    collide = false;
                    break;
                } else {
                    collide = false;
                    break;
                }
            }
            if (collide) {
                st.push(ast);
            }
        }
        vector<int> result(st.size());
        for (int i = st.size() - 1; i >= 0; --i) {
            result[i] = st.top();
            st.pop();
        }
        return result;
    }
};