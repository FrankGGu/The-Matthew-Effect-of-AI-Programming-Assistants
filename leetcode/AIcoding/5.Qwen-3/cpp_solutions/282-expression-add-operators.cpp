#include <iostream>
#include <vector>
#include <string>

using namespace std;

class Solution {
public:
    vector<string> addOperators(string num, string target) {
        vector<string> result;
        dfs(num, target, 0, "", 0, 0, result);
        return result;
    }

private:
    void dfs(string num, string target, int start, string path, long prev, long curr, vector<string>& result) {
        if (start == num.size()) {
            if (curr == stol(target)) {
                result.push_back(path);
            }
            return;
        }

        for (int i = start; i < num.size(); ++i) {
            if (i > start && num[start] == '0') break;
            string current = num.substr(start, i - start + 1);
            long val = stol(current);

            if (start == 0) {
                dfs(num, target, i + 1, current, val, val, result);
            } else {
                dfs(num, target, i + 1, path + "+" + current, val, curr + val, result);
                dfs(num, target, i + 1, path + "-" + current, -val, curr - val, result);
                dfs(num, target, i + 1, path + "*" + current, prev * val, curr - prev + prev * val, result);
            }
        }
    }
};