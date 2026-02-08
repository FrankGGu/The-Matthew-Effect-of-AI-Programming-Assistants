class Solution {
public:
    vector<string> filterEmails(vector<string>& emails) {
        vector<string> validEmails;
        for (const string& email : emails) {
            int atPos = email.find('@');
            if (atPos != string::npos && atPos > 0 && atPos < email.size() - 1) {
                string local = email.substr(0, atPos);
                string domain = email.substr(atPos + 1);
                if (isValidLocal(local) && isValidDomain(domain)) {
                    validEmails.push_back(email);
                }
            }
        }
        return validEmails;
    }

private:
    bool isValidLocal(const string& local) {
        for (char c : local) {
            if (!isalnum(c) && c != '.' && c != '_' && c != '-') return false;
        }
        return true;
    }

    bool isValidDomain(const string& domain) {
        int dotCount = 0;
        for (char c : domain) {
            if (!isalnum(c) && c != '.') return false;
            if (c == '.') dotCount++;
        }
        return dotCount > 0;
    }
};