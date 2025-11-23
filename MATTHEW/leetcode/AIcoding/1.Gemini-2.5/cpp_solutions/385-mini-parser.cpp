class NestedInteger {
public:
    // Constructor initializes an empty nested list.
    NestedInteger();

    // Constructor initializes a single integer.
    NestedInteger(int value);

    // Return true if this NestedInteger holds a single integer, rather than a nested list.
    bool isInteger() const;

    // Return the single integer that this NestedInteger holds, if it holds a single integer
    // The result is undefined if this NestedInteger holds a nested list
    int getInteger() const;

    // Set this NestedInteger to hold a single integer.
    void setInteger(int value);

    // Set this NestedInteger to hold a nested list and adds a nested integer to it.
    void add(const NestedInteger &ni);

    // Return the nested list that this NestedInteger holds, if it holds a single integer
    // The result is undefined if this NestedInteger holds a single integer
    const std::vector<NestedInteger> &getList() const;
};

class Solution {
public:
    NestedInteger deserialize(std::string s) {
        int pos = 0;
        return parse(s, pos);
    }

private:
    NestedInteger parse(const std::string& s, int& pos) {
        if (s[pos] == '[') {
            pos++; // Skip '['
            NestedInteger listNi;
            while (s[pos] != ']') {
                if (s[pos] == ',') {
                    pos++; // Skip ','
                }
                listNi.add(parse(s, pos));
            }
            pos++; // Skip ']'
            return listNi;
        } else {
            // It's an integer
            int sign = 1;
            if (s[pos] == '-') {
                sign = -1;
                pos++;
            }
            int num = 0;
            while (pos < s.length() && std::isdigit(s[pos])) {
                num = num * 10 + (s[pos] - '0');
                pos++;
            }
            return NestedInteger(num * sign);
        }
    }
};