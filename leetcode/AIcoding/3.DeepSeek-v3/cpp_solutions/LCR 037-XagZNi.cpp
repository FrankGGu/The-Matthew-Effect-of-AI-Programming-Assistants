#include <vector>
#include <stack>
using namespace std;

class Solution {
public:
    vector<int> asteroidCollision(vector<int>& asteroids) {
        stack<int> st;
        for (int ast : asteroids) {
            if (ast > 0) {
                st.push(ast);
            } else {
                while (!st.empty() && st.top() > 0 && st.top() < -ast) {
                    st.pop();
                }
                if (st.empty() || st.top() < 0) {
                    st.push(ast);
                } else if (st.top() == -ast) {
                    st.pop();
                }
            }
        }

        vector<int> res(st.size());
        for (int i = res.size() - 1; i >= 0; --i) {
            res[i] = st.top();
            st.pop();
        }
        return res;
    }
};