#include <string>
#include <queue>

using namespace std;

class Solution {
public:
    string repeatLimitedString(string s, int repeatLimit) {
        vector<int> counts(26, 0);
        for (char c : s) {
            counts[c - 'a']++;
        }

        priority_queue<pair<int, char>> pq;
        for (int i = 0; i < 26; ++i) {
            if (counts[i] > 0) {
                pq.push({counts[i], (char)('a' + i)});
            }
        }

        string result = "";
        while (!pq.empty()) {
            auto [count, ch] = pq.top();
            pq.pop();

            int repeat = min(count, repeatLimit);
            for (int i = 0; i < repeat; ++i) {
                result += ch;
            }

            if (count - repeat > 0) {
                if (!pq.empty()) {
                    auto [nextCount, nextCh] = pq.top();
                    pq.pop();
                    result += nextCh;
                    if (nextCount - 1 > 0) {
                        pq.push({nextCount - 1, nextCh});
                    }
                    pq.push({count - repeat, ch});
                } else {
                    break;
                }
            }
        }

        return result;
    }
};