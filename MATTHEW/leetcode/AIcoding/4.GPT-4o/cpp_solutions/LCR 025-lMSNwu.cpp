#include <stack>
#include <string>
using namespace std;

class Solution {
public:
    string addStrings(string num1, string num2) {
        stack<char> s1, s2;
        for (char c : num1) s1.push(c);
        for (char c : num2) s2.push(c);

        string result;
        int carry = 0;

        while (!s1.empty() || !s2.empty() || carry) {
            int sum = carry;
            if (!s1.empty()) {
                sum += s1.top() - '0';
                s1.pop();
            }
            if (!s2.empty()) {
                sum += s2.top() - '0';
                s2.pop();
            }
            carry = sum / 10;
            result.push_back(sum % 10 + '0');
        }

        reverse(result.begin(), result.end());
        return result;
    }
};