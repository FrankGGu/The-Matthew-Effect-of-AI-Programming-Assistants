#include <vector>
#include <string>
#include <algorithm>

using namespace std;

class Solution {
public:
    string largestStringFromBox(vector<string>& box) {
        string result;
        for (const string& s : box) {
            bool valid = true;
            for (char c : s) {
                if (c < 'a' || c > 'z') {
                    valid = false;
                    break;
                }
            }
            if (valid) {
                if (s > result) {
                    result = s;
                }
            }
        }
        return result;
    }
};