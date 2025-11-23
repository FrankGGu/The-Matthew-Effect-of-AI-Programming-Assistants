class Solution {
public:
    int numUniqueEmails(vector<string>& emails) {
        unordered_set<string> uniqueEmails;
        for (const string& email : emails) {
            string local, domain;
            bool seenPlus = false;
            for (char c : email) {
                if (c == '@') {
                    local += c;
                    break;
                }
                if (c == '+' && !seenPlus) {
                    seenPlus = true;
                }
                if (!seenPlus && c != '.') {
                    local += c;
                }
            }
            local += email.substr(email.find('@'));
            uniqueEmails.insert(local);
        }
        return uniqueEmails.size();
    }
};