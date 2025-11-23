class Solution {
public:
    vector<string> invalidIPAddresses(vector<string>& ipAddresses) {
        vector<string> result;
        for (const string& ip : ipAddresses) {
            if (!isValid(ip)) {
                result.push_back(ip);
            }
        }
        return result;
    }

private:
    bool isValid(const string& ip) {
        if (ip.empty()) return false;
        if (ip.find("..") != string::npos) return false;
        if (ip.front() == '.' || ip.back() == '.') return false;

        if (ip.find(':') != string::npos) {
            return isValidIPv6(ip);
        } else {
            return isValidIPv4(ip);
        }
    }

    bool isValidIPv4(const string& ip) {
        vector<string> parts;
        stringstream ss(ip);
        string part;

        while (getline(ss, part, '.')) {
            if (part.empty() || part.size() > 3 || (part.size() > 1 && part.front() == '0')) return false;
            int num = stoi(part);
            if (num < 0 || num > 255) return false;
            parts.push_back(part);
        }

        return parts.size() == 4;
    }

    bool isValidIPv6(const string& ip) {
        vector<string> parts;
        stringstream ss(ip);
        string part;

        while (getline(ss, part, ':')) {
            if (part.empty() || part.size() > 4 || !all_of(part.begin(), part.end(), ::isxdigit)) return false;
            parts.push_back(part);
        }

        return parts.size() == 8;
    }
};