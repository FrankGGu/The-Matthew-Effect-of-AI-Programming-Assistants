#include <string>
#include <queue>
#include <utility> // For std::pair

class Solution {
public:
    std::string longestDiverseString(int a, int b, int c) {
        std::string res = "";

        // Priority queue stores pairs of (count, character)
        // It's a max-heap, so the character with the highest count is always at the top.
        std::priority_queue<std::pair<int, char>> pq;

        if (a > 0) pq.push({a, 'a'});
        if (b > 0) pq.push({b, 'b'});
        if (c > 0) pq.push({c, 'c'});

        while (!pq.empty()) {
            std::pair<int, char> p1 = pq.top();
            pq.pop();

            // Check if we can append p1.second
            // We cannot append if the string already ends with two occurrences of p1.second
            bool can_append_p1 = true;
            if (res.size() >= 2 && res[res.size() - 1] == p1.second && res[res.size() - 2] == p1.second) {
                can_append_p1 = false;
            }

            if (can_append_p1) {
                res += p1.second;
                p1.first--;
                if (p1.first > 0) {
                    pq.push(p1);
                }
            } else {
                // If we cannot append p1.second, we must try to append the second most frequent character.
                // If there is no second character, we stop.
                if (pq.empty()) {
                    break;
                }

                std::pair<int, char> p2 = pq.top();
                pq.pop();

                res += p2.second;
                p2.first--;
                if (p2.first > 0) {
                    pq.push(p2);
                }

                // Put p1 back into the priority queue as it was not used in this iteration.
                pq.push(p1);
            }
        }

        return res;
    }
};