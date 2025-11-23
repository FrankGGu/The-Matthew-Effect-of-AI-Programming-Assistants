struct NestedInteger {
    // This is the interface that allows for creating nested lists.
    // You should not implement it, or speculate about its implementation
    bool isInteger();
    int getInteger();
    vector<NestedInteger>& getList();
};

NestedInteger deserialize(char* s) {
    if (s[0] != '[') {
        return NestedInteger(atoi(s));
    }
    stack<NestedInteger> stk;
    NestedInteger curr;
    for (int i = 0; s[i]; ++i) {
        if (s[i] == '[') {
            stk.push(curr);
            curr = NestedInteger();
        } else if (s[i] == ']') {
            if (i > 0 && isdigit(s[i - 1])) {
                curr.add(NestedInteger(atoi(s + start)));
            }
            if (!stk.empty()) {
                NestedInteger top = stk.top();
                stk.pop();
                top.add(curr);
                curr = top;
            }
        } else if (s[i] == ',') {
            if (i > 0 && isdigit(s[i - 1])) {
                curr.add(NestedInteger(atoi(s + start)));
            }
            start = i + 1;
        }
    }
    return curr;
}