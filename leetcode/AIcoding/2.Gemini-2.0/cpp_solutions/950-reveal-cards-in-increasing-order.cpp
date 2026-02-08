#include <vector>
#include <deque>
#include <algorithm>

using namespace std;

class Solution {
public:
    vector<int> deckRevealedIncreasing(vector<int>& deck) {
        int n = deck.size();
        sort(deck.begin(), deck.end());

        deque<int> dq;
        for (int i = 0; i < n; ++i) {
            dq.push_back(i);
        }

        vector<int> result(n);
        int deckIndex = 0;
        while (!dq.empty()) {
            int index = dq.front();
            dq.pop_front();
            result[index] = deck[deckIndex++];

            if (!dq.empty()) {
                int temp = dq.front();
                dq.pop_front();
                dq.push_back(temp);
            }
        }

        return result;
    }
};