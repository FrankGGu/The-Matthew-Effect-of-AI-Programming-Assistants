#include <iostream>
#include <vector>
#include <string>
#include <queue>
#include <unordered_map>

using namespace std;

class Solution {
public:
    int minValidStrings(vector<string>& words, string target) {
        unordered_map<string, int> wordCount;
        for (const string& word : words) {
            ++wordCount[word];
        }

        queue<pair<string, int>> q;
        q.push({ "", 0 });

        while (!q.empty()) {
            auto [current, steps] = q.front();
            q.pop();

            if (current == target) {
                return steps;
            }

            for (const string& word : words) {
                string next = current + word;
                if (next.length() > target.length()) {
                    continue;
                }
                if (next == target.substr(0, next.length())) {
                    q.push({ next, steps + 1 });
                }
            }
        }

        return -1;
    }
};