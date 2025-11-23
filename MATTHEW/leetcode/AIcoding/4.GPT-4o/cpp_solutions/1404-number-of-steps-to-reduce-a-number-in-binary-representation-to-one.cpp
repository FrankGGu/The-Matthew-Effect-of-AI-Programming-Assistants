class Solution {
public:
    int numSteps(string s) {
        int steps = 0;
        int carry = 0;

        for (int i = s.size() - 1; i > 0; --i) {
            if (s[i] == '0') {
                steps += 1; // Remove the least significant bit
            } else {
                steps += 2; // Remove the least significant bit and add 1
            }
        }

        return steps + carry;
    }
};