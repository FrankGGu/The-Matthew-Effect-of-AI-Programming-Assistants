class Solution {
public:
    int numUniqueEmails(vector<string>& emails) {
        unordered_set<string> uniqueEmails;
        for (const string& email : emails) {
            string processedEmail;
            bool ignore = false;
            bool domain = false;
            for (char c : email) {
                if (c == '@') {
                    domain = true;
                    ignore = false;
                }
                if (domain) {
                    processedEmail += c;
                } else {
                    if (c == '+') {
                        ignore = true;
                    }
                    if (!ignore && c != '.') {
                        processedEmail += c;
                    }
                }
            }
            uniqueEmails.insert(processedEmail);
        }
        return uniqueEmails.size();
    }
};