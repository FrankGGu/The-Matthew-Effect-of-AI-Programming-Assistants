#include <string>

using namespace std;

class Solution {
public:
    string getHappyString(int n, int k) {
        string res = "";
        int count = 0;

        function<void(string)> solve = [&](string current) {
            if (count >= k) return;
            if (current.length() == n) {
                count++;
                if (count == k) {
                    res = current;
                }
                return;
            }

            for (char c : {'a', 'b', 'c'}) {
                if (current.empty() || current.back() != c) {
                    solve(current + c);
                }
            }
        };

        solve("");
        return res;
    }
};