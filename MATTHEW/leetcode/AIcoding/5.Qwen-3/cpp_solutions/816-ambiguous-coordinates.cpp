#include <iostream>
#include <vector>
#include <string>
#include <sstream>

using namespace std;

class Solution {
public:
    vector<string> ambiguousCoordinates(string s) {
        vector<string> result;
        s = s.substr(1, s.size() - 2);
        for (int i = 1; i < s.size(); ++i) {
            vector<string> left = generate(s.substr(0, i));
            vector<string> right = generate(s.substr(i));
            for (string l : left) {
                for (string r : right) {
                    result.push_back("(" + l + ", " + r + ")");
                }
            }
        }
        return result;
    }

private:
    vector<string> generate(string s) {
        vector<string> res;
        if (s.size() == 1) {
            res.push_back(s);
            return res;
        }
        if (s[0] != '0') {
            res.push_back(s);
        }
        for (int i = 1; i < s.size(); ++i) {
            string integer = s.substr(0, i);
            string fraction = s.substr(i);
            if (integer[0] != '0' && fraction.back() != '0') {
                res.push_back(integer + "." + fraction);
            }
        }
        return res;
    }
};