#include <string>
#include <vector>
#include <sstream>
#include <unordered_map>

using namespace std;

class Solution {
public:
    int evaluate(string expression) {
        return eval(expression, {});
    }

private:
    int eval(string s, unordered_map<string, int> env) {
        if (isdigit(s[0]) || s[0] == '-') {
            return stoi(s);
        }
        if (env.count(s)) {
            return env[s];
        }

        if (s[1] == 'l') { // let
            vector<string> tokens = parse(s.substr(5, s.size() - 6));
            unordered_map<string, int> new_env = env;
            for (int i = 0; i < tokens.size() - 1; i += 2) {
                new_env[tokens[i]] = eval(tokens[i + 1], new_env);
            }
            return eval(tokens.back(), new_env);
        } else if (s[1] == 'a') { // add
            vector<string> tokens = parse(s.substr(5, s.size() - 6));
            return eval(tokens[0], env) + eval(tokens[1], env);
        } else { // mult
            vector<string> tokens = parse(s.substr(6, s.size() - 7));
            return eval(tokens[0], env) * eval(tokens[1], env);
        }
    }

    vector<string> parse(string s) {
        vector<string> tokens;
        int start = 0;
        int count = 0;
        for (int i = 0; i < s.size(); ++i) {
            if (s[i] == '(') {
                count++;
            } else if (s[i] == ')') {
                count--;
            }

            if (s[i] == ' ' && count == 0) {
                tokens.push_back(s.substr(start, i - start));
                start = i + 1;
            }
        }
        tokens.push_back(s.substr(start));
        return tokens;
    }
};