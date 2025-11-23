#include <string>
#include <vector>
#include <sstream>

using namespace std;

class Solution {
public:
    string validIPAddress(string IP) {
        if (IP.find('.') != string::npos) {
            if (isValidIPv4(IP)) return "IPv4";
        } else if (IP.find(':') != string::npos) {
            if (isValidIPv6(IP)) return "IPv6";
        }
        return "Neither";
    }

private:
    bool isValidIPv4(string IP) {
        vector<string> parts;
        stringstream ss(IP);
        string part;
        while (getline(ss, part, '.')) {
            parts.push_back(part);
        }

        if (parts.size() != 4) return false;

        for (const string& p : parts) {
            if (p.empty() || p.length() > 3) return false;
            if (p.length() > 1 && p[0] == '0') return false;
            for (char c : p) {
                if (!isdigit(c)) return false;
            }
            int num = stoi(p);
            if (num < 0 || num > 255) return false;
        }

        return true;
    }

    bool isValidIPv6(string IP) {
        vector<string> parts;
        stringstream ss(IP);
        string part;
        while (getline(ss, part, ':')) {
            parts.push_back(part);
        }

        if (parts.size() != 8) return false;

        for (const string& p : parts) {
            if (p.empty() || p.length() > 4) return false;
            for (char c : p) {
                if (!isxdigit(c)) return false;
            }
        }

        return true;
    }
};