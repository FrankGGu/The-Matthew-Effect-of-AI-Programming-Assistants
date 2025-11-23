class Solution {
public:
    string constructSequence(int n) {
        string result;
        for (int i = n; i > 0; --i) {
            result += to_string(i);
        }
        return result;
    }
};