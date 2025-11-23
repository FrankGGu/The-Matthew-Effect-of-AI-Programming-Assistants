#include <string>
#include <vector>
#include <queue>
#include <utility>

using namespace std;

class Solution {
public:
    string repeatLimitedString(string s, int repeatLimit) {
        vector<int> count(26, 0);
        for (char c : s) {
            count[c - 'a']++;
        }

        priority_queue<pair<int, char>> pq;
        for (int i = 0; i < 26; i++) {
            if (count[i] > 0) {
                pq.push({count[i], 'a' + i});
            }
        }

        string result;
        while (!pq.empty()) {
            auto [cnt, ch] = pq.top();
            pq.pop();
            int take = min(cnt, repeatLimit);
            result.append(take, ch);
            cnt -= take;

            if (cnt > 0) {
                if (pq.empty()) break;
                auto [next_cnt, next_ch] = pq.top();
                pq.pop();
                result += next_ch;
                next_cnt--;
                pq.push({next_cnt, next_ch});
                pq.push({cnt, ch});
            }
        }

        return result;
    }
};