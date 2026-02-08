class Solution {
public:
    int kthPalindrome(vector<int>& queries, int intLength) {
        int base = pow(10, (intLength - 1) / 2);
        vector<int> results;

        for (int q : queries) {
            int num = base + q - 1;
            string s = to_string(num);
            string palindrome = s;
            if (intLength % 2 == 0) {
                reverse(s.begin(), s.end());
                palindrome += s;
            } else {
                reverse(s.begin() + 1, s.end());
                palindrome += s.substr(1);
            }
            if (palindrome.length() == intLength) {
                results.push_back(stoi(palindrome));
            } else {
                results.push_back(-1);
            }
        }

        return results;
    }
};