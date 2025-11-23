#include <iostream>
#include <vector>
#include <string>
#include <queue>

using namespace std;

class Solution {
public:
    string longestHappyString(int a, int b, int c) {
        auto comp = [](const pair<int, char>& a, const pair<int, char>& b) {
            return a.first < b.first;
        };

        priority_queue<pair<int, char>, vector<pair<int, char>>, decltype(comp)> maxHeap(comp);

        if (a > 0) maxHeap.push({a, 'a'});
        if (b > 0) maxHeap.push({b, 'b'});
        if (c > 0) maxHeap.push({c, 'c'});

        string result;

        while (!maxHeap.empty()) {
            auto [count, ch] = maxHeap.top();
            maxHeap.pop();

            if (result.size() >= 2 && result[result.size() - 1] == ch && result[result.size() - 2] == ch) {
                if (maxHeap.empty()) break;
                auto [nextCount, nextCh] = maxHeap.top();
                maxHeap.pop();
                result += nextCh;
                if (--nextCount > 0) maxHeap.push({nextCount, nextCh});
                maxHeap.push({count, ch});
            } else {
                result += ch;
                if (--count > 0) maxHeap.push({count, ch});
            }
        }

        return result;
    }
};