#include <vector>
#include <algorithm>
#include <queue>

using namespace std;

vector<int> deckRevealedIncreasing(vector<int>& deck) {
    sort(deck.begin(), deck.end());
    vector<int> result(deck.size());
    deque<int> dq;
    dq.push_back(0);

    for (int i = 1; i < deck.size(); ++i) {
        dq.push_back(dq.front());
        dq.pop_front();
        dq.push_back(i);
    }

    for (int i = 0; i < deck.size(); ++i) {
        result[dq.front()] = deck[i];
        dq.pop_front();
    }

    return result;
}