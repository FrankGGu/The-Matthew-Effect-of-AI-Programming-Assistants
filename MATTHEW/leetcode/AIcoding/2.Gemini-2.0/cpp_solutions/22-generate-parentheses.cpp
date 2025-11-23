#include <vector>
#include <string>

using namespace std;

class Solution {
public:
    vector<string> generateParenthesis(int n) {
        vector<string> result;
        generate(result, "", n, 0, 0);
        return result;
    }

private:
    void generate(vector<string>& result, string current, int n, int open, int close) {
        if (current.length() == 2 * n) {
            result.push_back(current);
            return;
        }

        if (open < n) {
            generate(result, current + "(", n, open + 1, close);
        }

        if (close < open) {
            generate(result, current + ")", n, open, close + 1);
        }
    }
};