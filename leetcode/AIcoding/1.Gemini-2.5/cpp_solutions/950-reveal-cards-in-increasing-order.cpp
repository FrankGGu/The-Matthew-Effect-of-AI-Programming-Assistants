#include <vector>
#include <algorithm>
#include <deque>

class Solution {
public:
    std::vector<int> deckRevealedIncreasing(std::vector<int>& deck) {
        int n = deck.size();
        std::sort(deck.begin(), deck.end());

        std::vector<int> result(n);
        std::deque<int> indices;

        for (int i = 0; i < n; ++i) {
            indices.push_back(i);
        }

        for (int i = 0; i < n; ++i) {
            result[indices.front()] = deck[i];
            indices.pop_front();

            if (!indices.empty()) {
                indices.push_back(indices.front());
                indices.pop_front();
            }
        }

        return result;
    }
};