#include <iostream>
#include <vector>
#include <string>
#include <map>
#include <stack>

using namespace std;

class Solution {
public:
    string countOfAtoms(string formula) {
        stack<map<string, int>> s;
        s.push({});
        int i = 0;
        while (i < formula.size()) {
            char c = formula[i];
            if (c == '(') {
                s.push({});
                i++;
            } else if (c == ')') {
                i++;
                int num = 0;
                while (i < formula.size() && isdigit(formula[i])) {
                    num = num * 10 + (formula[i] - '0');
                    i++;
                }
                num = num == 0 ? 1 : num;
                map<string, int> top = s.top();
                s.pop();
                for (auto& [key, val] : top) {
                    s.top()[key] += val * num;
                }
            } else {
                int j = i + 1;
                while (j < formula.size() && (islower(formula[j]) || isdigit(formula[j]))) {
                    if (islower(formula[j])) {
                        j++;
                    } else {
                        break;
                    }
                }
                string name = formula.substr(i, j - i);
                i = j;
                int num = 0;
                while (i < formula.size() && isdigit(formula[i])) {
                    num = num * 10 + (formula[i] - '0');
                    i++;
                }
                num = num == 0 ? 1 : num;
                s.top()[name] += num;
            }
        }
        map<string, int> result = s.top();
        string res;
        for (auto& [name, count] : result) {
            res += name;
            if (count > 1) {
                res += to_string(count);
            }
        }
        return res;
    }
};