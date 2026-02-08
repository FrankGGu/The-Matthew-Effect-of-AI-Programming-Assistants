#include <string>
#include <stack>

using namespace std;

class Solution {
public:
    string removeKdigits(string num, int k) {
        stack<char> s;
        int n = num.size();
        for (char c : num) {
            while (!s.empty() && k > 0 && s.top() > c) {
                s.pop();
                k--;
            }
            s.push(c);
        }

        while (k > 0) {
            s.pop();
            k--;
        }

        string res = "";
        while (!s.empty()) {
            res = s.top() + res;
            s.pop();
        }

        int i = 0;
        while (i < res.size() - 1 && res[i] == '0') {
            i++;
        }

        res = res.substr(i);
        return res.empty() ? "0" : res;
    }
};