#include <iostream>
#include <vector>
#include <string>
#include <queue>

using namespace std;

class Solution {
public:
    string repeatLimitedQueue(string s, int repeatLimit) {
        vector<int> count(26, 0);
        for (char c : s) {
            count[c - 'a']++;
        }

        priority_queue<pair<int, char>> pq;
        for (int i = 0; i < 26; ++i) {
            if (count[i] > 0) {
                pq.push({count[i], 'a' + i});
            }
        }

        string result;
        while (!pq.empty()) {
            auto [freq1, ch1] = pq.top();
            pq.pop();

            int used = min(freq1, repeatLimit);
            result.append(used, ch1);
            freq1 -= used;

            if (freq1 > 0) {
                if (pq.empty()) {
                    break;
                }
                auto [freq2, ch2] = pq.top();
                pq.pop();
                result.push_back(ch2);
                --freq2;
                if (freq2 > 0) {
                    pq.push({freq2, ch2});
                }
                pq.push({freq1, ch1});
            }
        }

        return result;
    }
};