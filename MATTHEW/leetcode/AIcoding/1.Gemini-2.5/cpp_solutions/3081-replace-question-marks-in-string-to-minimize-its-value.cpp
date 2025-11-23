#include <string>
#include <vector>
#include <queue>
#include <algorithm>
#include <utility>

class Solution {
public:
    std::string minimizeStringValue(std::string s) {
        std::vector<int> freq(26, 0);
        int q_count = 0;
        for (char c : s) {
            if (c == '?') {
                q_count++;
            } else {
                freq[c - 'a']++;
            }
        }

        if (q_count == 0) {
            return s;
        }

        using P = std::pair<int, char>;
        std::priority_queue<P, std::vector<P>, std::greater<P>> pq;
        for (int i = 0; i < 26; ++i) {
            pq.push({freq[i], (char)('a' + i)});
        }

        for (int i = 0; i < q_count; ++i) {
            P top = pq.top();
            pq.pop();
            top.first++;
            pq.push(top);
        }

        std::vector<int> target_freq(26, 0);
        while (!pq.empty()) {
            P top = pq.top();
            pq.pop();
            target_freq[top.second - 'a'] = top.first;
        }

        std::string t = "";
        for (int i = 0; i < 26; ++i) {
            int needed = target_freq[i] - freq[i];
            if (needed > 0) {
                t += std::string(needed, (char)('a' + i));
            }
        }

        int t_idx = 0;
        for (int i = 0; i < s.length(); ++i) {
            if (s[i] == '?') {
                s[i] = t[t_idx++];
            }
        }

        return s;
    }
};