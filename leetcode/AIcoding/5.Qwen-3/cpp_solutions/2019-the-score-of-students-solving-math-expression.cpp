#include <iostream>
#include <vector>
#include <stack>
#include <unordered_map>
#include <sstream>

using namespace std;

class Solution {
public:
    int scoreOfStudents(string s) {
        unordered_map<int, int> correct;
        stack<int> st;
        int i = 0;
        while (i < s.size()) {
            if (s[i] == ' ') {
                i++;
                continue;
            }
            if (isdigit(s[i])) {
                int num = 0;
                while (i < s.size() && isdigit(s[i])) {
                    num = num * 10 + (s[i] - '0');
                    i++;
                }
                st.push(num);
            } else if (s[i] == '(') {
                st.push('(');
                i++;
            } else if (s[i] == ')') {
                int val = 0;
                while (st.top() != '(') {
                    val += st.top();
                    st.pop();
                }
                st.pop();
                st.push(val);
                i++;
            } else {
                int val = 0;
                while (!st.empty() && st.top() != '(') {
                    val += st.top();
                    st.pop();
                }
                st.push(val);
                st.push(s[i]);
                i++;
            }
        }
        int total = 0;
        while (!st.empty()) {
            total += st.top();
            st.pop();
        }
        correct[total] = 1;

        vector<int> res;
        i = 0;
        stack<int> st2;
        while (i < s.size()) {
            if (s[i] == ' ') {
                i++;
                continue;
            }
            if (isdigit(s[i])) {
                int num = 0;
                while (i < s.size() && isdigit(s[i])) {
                    num = num * 10 + (s[i] - '0');
                    i++;
                }
                st2.push(num);
            } else if (s[i] == '(') {
                st2.push('(');
                i++;
            } else if (s[i] == ')') {
                int val = 0;
                while (st2.top() != '(') {
                    val += st2.top();
                    st2.pop();
                }
                st2.pop();
                st2.push(val);
                i++;
            } else {
                int val = 0;
                while (!st2.empty() && st2.top() != '(') {
                    val += st2.top();
                    st2.pop();
                }
                st2.push(val);
                st2.push(s[i]);
                i++;
            }
        }
        int total2 = 0;
        while (!st2.empty()) {
            total2 += st2.top();
            st2.pop();
        }

        for (int i = 1; i <= 1000; i++) {
            if (i == total2) continue;
            if (correct.find(i) != correct.end()) {
                res.push_back(i);
            }
        }

        int score = 0;
        for (int num : res) {
            score += num;
        }
        return score;
    }
};