#include <string>
#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    string getHappyString(int n, int k) {
        int count = 0;
        string result = "";
        function<void(string)> solve = [&](string current) {
            if (current.length() == n) {
                count++;
                if (count == k) {
                    result = current;
                }
                return;
            }

            if (count >= k) return;

            for (char c : {'a', 'b', 'c'}) {
                if (current.empty() || c != current.back()) {
                    solve(current + c);
                }
            }
        };

        solve("");
        return result;
    }
};