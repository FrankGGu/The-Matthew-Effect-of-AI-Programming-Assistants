class Solution {
public:
    string maximumNumber(string num, vector<int>& change) {
        bool mutated = false;
        for (char &c : num) {
            int digit = c - '0';
            if (change[digit] > digit) {
                c = change[digit] + '0';
                mutated = true;
            } else if (change[digit] < digit && mutated) {
                break;
            }
        }
        return num;
    }
};