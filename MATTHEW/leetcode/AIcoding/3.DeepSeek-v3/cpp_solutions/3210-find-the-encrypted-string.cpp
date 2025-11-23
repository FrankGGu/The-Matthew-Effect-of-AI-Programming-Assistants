#include <string>
using namespace std;

class Solution {
public:
    string encryptString(string s) {
        if (s.empty()) return "";
        string result;
        int n = s.size();
        int left = 0;
        int right = n - 1;
        while (left <= right) {
            if (left == right) {
                result += s[left];
                break;
            }
            result += s[left];
            result += s[right];
            left++;
            right--;
        }
        return result;
    }
};