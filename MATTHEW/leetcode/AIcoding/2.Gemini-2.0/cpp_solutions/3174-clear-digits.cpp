#include <string>
#include <algorithm>

using namespace std;

class Solution {
public:
    string clearDigits(string num, int k) {
        string res = "";
        for (char c : num) {
            while (!res.empty() && res.back() < c && k > 0) {
                res.pop_back();
                k--;
            }
            res.push_back(c);
        }
        while (k > 0) {
            res.pop_back();
            k--;
        }
        int i = 0;
        while (i < res.size() - 1 && res[i] == '0') {
            i++;
        }
        return res.substr(i);
    }
};