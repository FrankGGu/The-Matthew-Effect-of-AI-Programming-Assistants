class Solution {
public:
    bool isValid(string code) {
        int n = code.size();
        stack<string> tags;
        int i = 0;

        while (i < n) {
            if (code[i] == '<') {
                if (i + 1 < n && code[i + 1] == '/') {
                    int closingTagStart = i + 2;
                    int closingTagEnd = code.find('>', closingTagStart);
                    if (closingTagEnd == string::npos || closingTagEnd == closingTagStart) return false;
                    string tagName = code.substr(closingTagStart, closingTagEnd - closingTagStart);
                    if (tags.empty() || tags.top() != tagName) return false;
                    tags.pop();
                    i = closingTagEnd + 1;
                } else {
                    int openingTagStart = i + 1;
                    int openingTagEnd = code.find('>', openingTagStart);
                    if (openingTagEnd == string::npos || openingTagEnd == openingTagStart) return false;
                    string tagName = code.substr(openingTagStart, openingTagEnd - openingTagStart);
                    if (tagName.empty() || !isValidTag(tagName)) return false;
                    tags.push(tagName);
                    i = openingTagEnd + 1;
                }
            } else {
                if (tags.empty()) return false;
                i++;
            }
        }

        return tags.empty();
    }

private:
    bool isValidTag(const string& tag) {
        if (tag.size() < 1 || tag.size() > 9) return false;
        for (char c : tag) {
            if (!isalnum(c)) return false;
        }
        return true;
    }
};