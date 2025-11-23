#include <iostream>
#include <vector>
#include <stack>

using namespace std;

class Solution {
public:
    bool validateStackSequences(vector<int>& pushed, vector<int>& popped) {
        stack<int> s;
        int i = 0;
        for (int p : pushed) {
            s.push(p);
            while (!s.empty() && s.top() == popped[i]) {
                s.pop();
                i++;
            }
        }
        return i == popped.size();
    }
};