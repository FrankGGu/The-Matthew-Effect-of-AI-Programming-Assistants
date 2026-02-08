#include <iostream>
#include <vector>
#include <string>

using namespace std;

class Solution {
public:
    string validIPAddress(string IP) {
        if (IP.empty()) return "Neither";
        if (IP.find('.') != string::npos) {
            return validateIPv4(IP);
        } else if (IP.find(':') != string::npos) {
            return validateIPv6(IP);
        } else {
            return "Neither";
        }
    }

private:
    string validateIPv4(string ip) {
        vector<string> parts;
        string part;
        for (char c : ip) {
            if (c == '.') {
                if (part.empty()) return "Neither";
                parts.push_back(part);
                part.clear();
            } else {
                part += c;
            }
        }
        if (part.empty()) return "Neither";
        parts.push_back(part);

        if (parts.size() != 4) return "Neither";

        for (const string& p : parts) {
            if (p.length() > 3 || p.length() == 0) return "Neither";
            if (p[0] == '0' && p.length() > 1) return "Neither";
            for (char c : p) {
                if (!isdigit(c)) return "Neither";
            }
            int num = stoi(p);
            if (num < 0 || num > 255) return "Neither";
        }
        return "IPv4";
    }

    string validateIPv6(string ip) {
        vector<string> parts;
        string part;
        for (char c : ip) {
            if (c == ':') {
                if (part.empty()) return "Neither";
                parts.push_back(part);
                part.clear();
            } else {
                part += c;
            }
        }
        if (part.empty()) return "Neither";
        parts.push_back(part);

        if (parts.size() != 8) return "Neither";

        for (const string& p : parts) {
            if (p.length() > 4 || p.length() == 0) return "Neither";
            for (char c : p) {
                if (!(isalnum(c) || c == 'a' || c == 'b' || c == 'c' || c == 'd' || c == 'e' || c == 'f' ||
                      c == 'A' || c == 'B' || c == 'C' || c == 'D' || c == 'E' || c == 'F')) {
                    return "Neither";
                }
            }
        }
        return "IPv6";
    }
};