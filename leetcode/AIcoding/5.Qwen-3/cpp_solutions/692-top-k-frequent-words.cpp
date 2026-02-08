#include <iostream>
#include <vector>
#include <unordered_map>
#include <queue>
#include <string>
#include <algorithm>

using namespace std;

class Solution {
public:
    vector<string> topKFrequentWords(vector<string>& words, int k) {
        unordered_map<string, int> freq;
        for (const string& word : words) {
            freq[word]++;
        }

        auto compare = [&](const pair<int, string>& a, const pair<int, string>& b) {
            return a.first == b.first ? a.second < b.second : a.first > b.first;
        };

        priority_queue<pair<int, string>, vector<pair<int, string>>, decltype(compare)> pq(compare);

        for (const auto& [word, count] : freq) {
            pq.push({count, word});
            if (pq.size() > k) {
                pq.pop();
            }
        }

        vector<string> result(k);
        for (int i = k - 1; i >= 0; --i) {
            result[i] = pq.top().second;
            pq.pop();
        }

        return result;
    }
};