#include <iostream>
#include <vector>
#include <string>
#include <sstream>

using namespace std;

class Solution {
public:
    vector<string> invalidIPs(vector<string>& ips) {
        vector<string> result;
        for (const string& ip : ips) {
            if (!isValid(ip)) {
                result.push_back(ip);
            }
        }
        return result;
    }

private:
    bool isValid(const string& ip) {
        int count = 0;
        string token;
        stringstream ss(ip);
        while (getline(ss, token, '.')) {
            count++;
            if (token.empty() || token.length() > 3) return false;
            if (token[0] == '0' && token.length() > 1) return false;
            for (char c : token) {
                if (!isdigit(c)) return false;
            }
            int num = stoi(token);
            if (num < 0 || num > 255) return false;
        }
        return count == 4;
    }
};