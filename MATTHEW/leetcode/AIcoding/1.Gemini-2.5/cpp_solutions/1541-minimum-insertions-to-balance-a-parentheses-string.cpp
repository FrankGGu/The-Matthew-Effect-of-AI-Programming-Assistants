class Solution {
public:
    int minInsertions(std::string s) {
        int insertions = 0;
        int open_needed = 0; 

        for (int i = 0; i < s.length(); ++i) {
            if (s[i] == '(') {
                open_needed++;
            } else { // s[i] == ')'
                if (open_needed > 0) {
                    open_needed--;
                } else {
                    insertions++; 
                }

                // We have one ')' (either s[i] or an inserted one if open_needed was 0).
                // We need a second ')' to form a valid pair "))".
                if (i + 1 < s.length() && s[i+1] == ')') {
                    i++; // Consume the second ')'
                } else {
                    insertions++; // We need to insert the second ')'
                }
            }
        }

        // After iterating, any remaining open '(' need two ')'s each.
        insertions += open_needed * 2;

        return insertions;
    }
};