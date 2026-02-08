#include <iostream>
#include <vector>
#include <stack>

using namespace std;

class Solution {
public:
    bool validateBookOrder(vector<int>& putIn, vector<int>& takeOut) {
        stack<int> s;
        int i = 0;
        for (int book : putIn) {
            s.push(book);
            while (!s.empty() && s.top() == takeOut[i]) {
                s.pop();
                i++;
            }
        }
        return i == takeOut.size();
    }
};