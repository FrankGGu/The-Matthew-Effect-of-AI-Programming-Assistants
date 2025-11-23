#include <string>
#include <sstream>
#include <algorithm>
#include <cctype>

class Solution {
public:
    std::string validIPAddress(std::string queryIP) {
        if (std::count(queryIP.begin(), queryIP.end(), '.') == 3) {
            if (isIPv4(queryIP)) {
                return "IPv4";
            }
        } else if (std::count(queryIP.begin(), queryIP.end(), ':') == 7) {
            if (isIPv6(queryIP)) {
                return "IPv6";
            }
        }
        return "Neither";
    }

private:
    bool isIPv4(const std::string& ip) {
        std::stringstream ss(ip);
        std::string part;
        while (std::getline(ss, part, '.')) {
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
            if (std::stoi(part) > 255) {
                return false;
            }
        }
        return true;
    }

    bool isIPv6(const std::string& ip) {
        std::stringstream ss(ip);
        std::string part;
        while (std::getline(ss, part, ':')) {
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
};