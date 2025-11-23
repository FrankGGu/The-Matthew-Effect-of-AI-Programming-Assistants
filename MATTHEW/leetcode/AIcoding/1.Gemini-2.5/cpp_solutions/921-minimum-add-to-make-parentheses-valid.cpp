class Solution {
public:
    int minAddToMakeValid(std::string s) {
        int balance = 0;
        int additions = 0;

        for (char c : s) {
            if (c == '(') {
                balance++;
            } else { // c == ')'
                if (balance > 0) {
                    balance--;
                } else {
                    additions++; // We need to add an opening parenthesis for this closing one
                }
            }
        }

        // After iterating, any remaining 'balance' means unmatched open parentheses
        // Each of these needs a closing parenthesis to be added
        additions += balance;

        return additions;
    }
};