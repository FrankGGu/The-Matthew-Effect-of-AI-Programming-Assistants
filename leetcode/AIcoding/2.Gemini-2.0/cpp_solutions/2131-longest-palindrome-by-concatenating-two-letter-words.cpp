#include <string>
#include <unordered_map>

using namespace std;

class Solution {
public:
    int longestPalindrome(vector<string>& words) {
        unordered_map<string, int> count;
        for (const string& word : words) {
            count[word]++;
        }

        int ans = 0;
        bool central = false;

        for (auto const& [word, cnt] : count) {
            string reversed = word;
            reverse(reversed.begin(), reversed.end());

            if (word == reversed) {
                ans += (cnt / 2) * 4;
                if (cnt % 2 == 1) {
                    central = true;
                }
            } else if (word < reversed && count.count(reversed)) {
                ans += min(cnt, count[reversed]) * 4;
            }
        }

        if (central) {
            ans += 2;
        }

        return ans;
    }
};