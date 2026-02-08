#include <string>
#include <stack>
#include <unordered_map>

using namespace std;

class Solution {
public:
    string evaluate(string s, vector<vector<string>>& knowledge) {
        unordered_map<string, string> map;
        for (const auto& pair : knowledge) {
            map[pair[0]] = pair[1];
        }

        string result;
        stack<int> indices;
        for (int i = 0; i < s.size(); ++i) {
            if (s[i] == '(') {
                indices.push(result.size());
                result += '?';
            } else if (s[i] == ')') {
                if (!indices.empty()) {
                    int start = indices.top();
                    indices.pop();
                    result = result.substr(0, start) + (map.count(result.substr(start + 1)) ? map[result.substr(start + 1)] : "") + result.substr(result.size());
                }
            } else {
                if (indices.empty()) {
                    result += s[i];
                } else {
                    result[result.size() - 1] = s[i];
                }
            }
        }
        return result;
    }
};