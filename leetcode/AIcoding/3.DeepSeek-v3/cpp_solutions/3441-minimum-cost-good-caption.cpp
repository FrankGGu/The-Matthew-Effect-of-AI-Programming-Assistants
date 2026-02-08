#include <vector>
#include <algorithm>
#include <climits>

using namespace std;

class Solution {
public:
    long long minimumCost(string sentence, int k) {
        vector<string> words;
        string word;
        for (char c : sentence) {
            if (c == ' ') {
                words.push_back(word);
                word.clear();
            } else {
                word += c;
            }
        }
        if (!word.empty()) {
            words.push_back(word);
        }

        int n = words.size();
        vector<long long> dp(n + 1, LLONG_MAX);
        dp[n] = 0;

        for (int i = n - 1; i >= 0; --i) {
            int len = -1;
            long long cost = LLONG_MAX;
            for (int j = i; j < n; ++j) {
                len += words[j].size() + 1;
                if (len > k) break;
                if (j == n - 1) {
                    cost = 0;
                } else {
                    long long current = (k - len) * (k - len);
                    if (dp[j + 1] != LLONG_MAX) {
                        current += dp[j + 1];
                        if (current < cost) {
                            cost = current;
                        }
                    }
                }
            }
            dp[i] = cost;
        }

        return dp[0];
    }
};