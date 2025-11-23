class Solution {
public:
    bool checkString(string s) {
        return s.find('b') > s.find('a');
    }
};