class Solution {
public:
    string decodeString(string s) {
        stack<int> counts;
        stack<string> resultStack;
        string currentString = "";
        int currentNum = 0;

        for (char c : s) {
            if (isdigit(c)) {
                currentNum = currentNum * 10 + (c - '0');
            } else if (c == '[') {
                counts.push(currentNum);
                resultStack.push(currentString);
                currentNum = 0;
                currentString = "";
            } else if (c == ']') {
                string temp = resultStack.top();
                resultStack.pop();
                int count = counts.top();
                counts.pop();
                for (int i = 0; i < count; i++) {
                    temp += currentString;
                }
                currentString = temp;
            } else {
                currentString += c;
            }
        }

        return currentString;
    }
};