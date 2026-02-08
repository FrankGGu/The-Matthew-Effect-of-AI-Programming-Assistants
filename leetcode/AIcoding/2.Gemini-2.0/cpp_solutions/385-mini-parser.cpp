#include <string>
#include <vector>

using namespace std;

class NestedInteger {
public:
    NestedInteger() {}
    NestedInteger(int value) {}
    bool isInteger() const;
    int getInteger() const;
    void setInteger(int value);
    void add(const NestedInteger &ni);
    const vector<NestedInteger> &getList() const;
};

class Solution {
public:
    NestedInteger deserialize(string s) {
        int pos = 0;
        return parse(s, pos);
    }

private:
    NestedInteger parse(string& s, int& pos) {
        if (s[pos] == '[') {
            pos++;
            NestedInteger ni;
            while (s[pos] != ']') {
                ni.add(parse(s, pos));
                if (s[pos] == ',') {
                    pos++;
                }
            }
            pos++;
            return ni;
        } else {
            int sign = 1;
            if (s[pos] == '-') {
                sign = -1;
                pos++;
            }
            int num = 0;
            while (pos < s.size() && isdigit(s[pos])) {
                num = num * 10 + (s[pos] - '0');
                pos++;
            }
            return NestedInteger(sign * num);
        }
    }
};