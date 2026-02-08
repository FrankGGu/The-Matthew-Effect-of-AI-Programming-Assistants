class Solution {
public:
    bool backspaceCompare(string s, string t) {
        return process(s) == process(t);
    }

    string process(string str) {
        string result;
        for (char c : str) {
            if (c == '#') {
                if (!result.empty()) {
                    result.pop_back();
                }
            } else {
                result.push_back(c);
            }
        }
        return result;
    }
};