class Solution {
public:
    bool isValid(string code) {
        stack<string> st;
        int i = 0;
        int n = code.size();
        while (i < n) {
            if (i > 0 && st.empty()) return false;
            if (code.substr(i, 9) == "<![CDATA[") {
                int j = i + 9;
                i = code.find("]]>", j);
                if (i == string::npos) return false;
                i += 3;
            } else if (code.substr(i, 2) == "</") {
                int j = i + 2;
                i = code.find('>', j);
                if (i == string::npos) return false;
                string tag = code.substr(j, i - j);
                if (st.empty() || st.top() != tag) return false;
                st.pop();
                i++;
            } else if (code.substr(i, 1) == "<") {
                int j = i + 1;
                i = code.find('>', j);
                if (i == string::npos) return false;
                string tag = code.substr(j, i - j);
                if (tag.size() < 1 || tag.size() > 9) return false;
                for (char c : tag) {
                    if (!isupper(c)) return false;
                }
                st.push(tag);
                i++;
            } else {
                i++;
            }
        }
        return st.empty();
    }
};