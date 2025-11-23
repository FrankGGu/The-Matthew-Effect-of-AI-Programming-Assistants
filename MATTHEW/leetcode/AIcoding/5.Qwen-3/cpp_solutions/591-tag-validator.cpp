#include <iostream>
#include <vector>
#include <string>
#include <stack>
#include <cctype>

using namespace std;

class Solution {
public:
    string tagValidator(string code) {
        stack<string> tags;
        int i = 0;
        while (i < code.size()) {
            if (code[i] != '<') {
                i++;
                continue;
            }
            if (i + 1 >= code.size()) return "Not Valid";
            if (code[i + 1] == '/') {
                i += 2;
                string endTag;
                while (i < code.size() && isalpha(code[i])) {
                    endTag += code[i];
                    i++;
                }
                if (endTag.empty() || i >= code.size() || code[i] != '>') return "Not Valid";
                if (tags.empty() || tags.top() != endTag) return "Not Valid";
                tags.pop();
                i++;
            } else {
                i += 1;
                string startTag;
                while (i < code.size() && isalpha(code[i])) {
                    startTag += code[i];
                    i++;
                }
                if (startTag.empty() || i >= code.size() || code[i] != '>') return "Not Valid";
                tags.push(startTag);
                i++;
            }
        }
        return tags.empty() ? "Valid" : "Not Valid";
    }
};