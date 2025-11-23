#include <string>
#include <vector>
#include <queue>

using namespace std;

string reorganizeString(string s) {
    vector<int> count(26, 0);
    for (char c : s) {
        count[c - 'a']++;
    }

    priority_queue<pair<int, char>> maxHeap;
    for (int i = 0; i < 26; i++) {
        if (count[i] > 0) {
            maxHeap.push({count[i], 'a' + i});
        }
    }

    string result;
    pair<int, char> prev = {0, '#'};

    while (!maxHeap.empty()) {
        auto current = maxHeap.top();
        maxHeap.pop();
        result += current.second;

        if (prev.first > 0) {
            maxHeap.push(prev);
        }

        current.first--;
        prev = current;
    }

    return result.size() == s.size() ? result : "";
}