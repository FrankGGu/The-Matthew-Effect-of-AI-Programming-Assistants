#include <string>
#include <algorithm>

using namespace std;

class Solution {
public:
    string maxValue(string n, int x) {
        string result = "";
        bool inserted = false;
        if (n[0] == '-') {
            result += '-';
            for (int i = 1; i < n.size(); ++i) {
                if (!inserted && (n[i] - '0' > x)) {
                    result += to_string(x);
                    inserted = true;
                }
                result += n[i];
            }
            if (!inserted) {
                result += to_string(x);
            }
        } else {
            for (int i = 0; i < n.size(); ++i) {
                if (!inserted && (n[i] - '0' < x)) {
                    result += to_string(x);
                    inserted = true;
                }
                result += n[i];
            }
            if (!inserted) {
                result += to_string(x);
            }
        }
        return result;
    }
};