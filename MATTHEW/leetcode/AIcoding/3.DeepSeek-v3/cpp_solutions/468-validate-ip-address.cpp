class Solution {
public:
    string validIPAddress(string IP) {
        if (isIPv4(IP)) {
            return "IPv4";
        } else if (isIPv6(IP)) {
            return "IPv6";
        } else {
            return "Neither";
        }
    }

private:
    bool isIPv4(const string &IP) {
        int count = 0;
        for (char c : IP) {
            if (c == '.') {
                count++;
            }
        }
        if (count != 3) {
            return false;
        }

        vector<string> parts = split(IP, '.');
        if (parts.size() != 4) {
            return false;
        }

        for (string part : parts) {
            if (part.empty() || part.size() > 3) {
                return false;
            }
            if (part.size() > 1 && part[0] == '0') {
                return false;
            }
            for (char c : part) {
                if (!isdigit(c)) {
                    return false;
                }
            }
            int num = stoi(part);
            if (num < 0 || num > 255) {
                return false;
            }
        }
        return true;
    }

    bool isIPv6(const string &IP) {
        int count = 0;
        for (char c : IP) {
            if (c == ':') {
                count++;
            }
        }
        if (count != 7) {
            return false;
        }

        vector<string> parts = split(IP, ':');
        if (parts.size() != 8) {
            return false;
        }

        for (string part : parts) {
            if (part.empty() || part.size() > 4) {
                return false;
            }
            for (char c : part) {
                if (!isxdigit(c)) {
                    return false;
                }
            }
        }
        return true;
    }

    vector<string> split(const string &s, char delimiter) {
        vector<string> tokens;
        string token;
        istringstream tokenStream(s);
        while (getline(tokenStream, token, delimiter)) {
            tokens.push_back(token);
        }
        return tokens;
    }
};