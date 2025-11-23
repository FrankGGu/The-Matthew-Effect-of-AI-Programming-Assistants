#include <vector>
#include <deque>
#include <algorithm>

using namespace std;

class Solution {
public:
    vector<int> deckRevealedIncreasing(vector<int>& deck) {
        sort(deck.begin(), deck.end());
        deque<int> indices;
        for (int i = 0; i < deck.size(); ++i) {
            indices.push_back(i);
        }
        vector<int> result(deck.size());
        for (int card : deck) {
            result[indices.front()] = card;
            indices.pop_front();
            if (!indices.empty()) {
                indices.push_back(indices.front());
                indices.pop_front();
            }
        }
        return result;
    }
};