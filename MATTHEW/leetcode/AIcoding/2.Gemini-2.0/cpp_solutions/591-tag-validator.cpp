#include <string>
#include <vector>
#include <stack>

using namespace std;

class Solution {
public:
    bool isValid(string code) {
        stack<string> tags;
        int i = 0;
        while (i < code.size()) {
            if (code[i] == '<') {
                if (i + 1 < code.size() && code[i + 1] == '/') {
                    int j = i + 2;
                    while (j < code.size() && code[j] != '>') j++;
                    if (j == code.size()) return false;
                    string tag = code.substr(i + 2, j - i - 2);
                    if (tags.empty() || tags.top() != tag) return false;
                    tags.pop();
                    i = j + 1;
                } else if (i + 1 < code.size() && isupper(code[i + 1])) {
                    int j = i + 1;
                    while (j < code.size() && code[j] != '>') j++;
                    if (j == code.size()) return false;
                    string tag = code.substr(i + 1, j - i - 1);
                    if (tag.size() < 1 || tag.size() > 9) return false;
                    for (char c : tag) {
                        if (!isupper(c)) return false;
                    }
                    tags.push(tag);
                    i = j + 1;
                } else if (code[i+1] == '!') {
                    if (i + 9 <= code.size() && code.substr(i + 2, 7) == "[CDATA[" ) {
                        int j = i + 9;
                        while (j + 2 < code.size() && code.substr(j, 3) != "]]>") j++;
                        if (j + 2 >= code.size()) return false;
                        i = j + 3;
                    } else {
                        return false;
                    }
                } else {
                    return false;
                }
            } else {
                if (tags.empty()) return false;
                i++;
            }
        }
        return tags.empty();
    }
};