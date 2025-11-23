#include <string>
#include <unordered_set>

using namespace std;

class Solution {
public:
    int distinctEchoSubstrings(string text) {
        int n = text.size();
        unordered_set<string> distinctEchoes;

        for (int len = 1; len <= n / 2; ++len) {
            for (int i = 0; i <= n - 2 * len; ++i) {
                if (text.substr(i, len) == text.substr(i + len, len)) {
                    distinctEchoes.insert(text.substr(i, 2 * len));
                }
            }
        }

        return distinctEchoes.size();
    }
};