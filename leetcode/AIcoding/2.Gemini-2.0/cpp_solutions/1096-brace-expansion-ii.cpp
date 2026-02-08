#include <string>
#include <vector>
#include <set>

using namespace std;

class Solution {
public:
    set<string> evaluate(string s, int& pos) {
        set<string> res;
        set<string> current = {""};

        while (pos < s.size()) {
            if (s[pos] == ',') {
                res.insert(current.begin(), current.end());
                current = {""};
                pos++;
            } else if (s[pos] == '{') {
                pos++;
                set<string> next = evaluate(s, pos);
                set<string> temp;
                for (const string& str1 : current) {
                    for (const string& str2 : next) {
                        temp.insert(str1 + str2);
                    }
                }
                current = temp;
            } else if (s[pos] == '}') {
                res.insert(current.begin(), current.end());
                pos++;
                return res;
            } else {
                set<string> temp;
                for (const string& str : current) {
                    temp.insert(str + s[pos]);
                }
                current = temp;
                pos++;
            }
        }

        res.insert(current.begin(), current.end());
        return res;
    }

    vector<string> braceExpansionII(string expression) {
        int pos = 0;
        set<string> result = evaluate(expression, pos);
        vector<string> res(result.begin(), result.end());
        return res;
    }
};