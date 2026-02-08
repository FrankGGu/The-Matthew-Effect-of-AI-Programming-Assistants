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

    bool isValid(const string& ip) {
        if (ip.empty() || ip.size() < 7 || ip.size() > 15) {
            return false;
        }
        if (ip.find("..") != string::npos || ip.front() == '.' || ip.back() == '.') {
            return false;
        }
        vector<string> parts;
        stringstream ss(ip);
        string part;
        while (getline(ss, part, '.')) {
            if (part.empty() || part.size() > 3 || (part.size() > 1 && part.front() == '0')) {
                return false;
            }
            int num = stoi(part);
            if (num < 0 || num > 255) {
                return false;
            }
            parts.push_back(part);
        }
        return parts.size() == 4;
    }
};