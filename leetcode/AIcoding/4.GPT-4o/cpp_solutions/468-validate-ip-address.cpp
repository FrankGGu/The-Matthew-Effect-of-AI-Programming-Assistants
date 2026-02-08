class Solution {
public:
    string validIPAddress(string IP) {
        if (IP.find('.') != string::npos) {
            return isValidIPv4(IP) ? "IPv4" : "Neither";
        } 
        else if (IP.find(':') != string::npos) {
            return isValidIPv6(IP) ? "IPv6" : "Neither";
        }
        return "Neither";
    }

private:
    bool isValidIPv4(string IP) {
        vector<string> parts;
        stringstream ss(IP);
        string part;
        while (getline(ss, part, '.')) {
            if (part.empty() || part.size() > 3 || (part.size() > 1 && part[0] == '0') || !all_of(part.begin(), part.end(), ::isdigit) || stoi(part) < 0 || stoi(part) > 255) {
                return false;
            }
            parts.push_back(part);
        }
        return parts.size() == 4;
    }

    bool isValidIPv6(string IP) {
        vector<string> parts;
        stringstream ss(IP);
        string part;
        while (getline(ss, part, ':')) {
            if (part.empty() || part.size() > 4 || !all_of(part.begin(), part.end(), [](char c) { return isxdigit(c); })) {
                return false;
            }
            parts.push_back(part);
        }
        return parts.size() == 8;
    }
};