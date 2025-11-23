#include <string>
#include <queue>
#include <vector>

using namespace std;

class Solution {
public:
    string reorganizeString(string s) {
        vector<int> counts(26, 0);
        for (char c : s) {
            counts[c - 'a']++;
        }

        priority_queue<pair<int, char>> pq;
        for (int i = 0; i < 26; i++) {
            if (counts[i] > 0) {
                pq.push({counts[i], (char)('a' + i)});
            }
        }

        string result = "";
        while (!pq.empty()) {
            pair<int, char> first = pq.top();
            pq.pop();

            if (result.empty() || first.second != result.back()) {
                result += first.second;
                first.first--;
                if (first.first > 0) {
                    pq.push(first);
                }
            } else {
                if (pq.empty()) {
                    return "";
                }

                pair<int, char> second = pq.top();
                pq.pop();

                result += second.second;
                second.first--;
                if (second.first > 0) {
                    pq.push(second);
                }
                pq.push(first);
            }
        }

        return result;
    }
};