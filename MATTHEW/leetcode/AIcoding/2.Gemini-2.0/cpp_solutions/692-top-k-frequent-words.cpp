#include <vector>
#include <string>
#include <unordered_map>
#include <queue>

using namespace std;

struct Compare {
    bool operator()(const pair<string, int>& a, const pair<string, int>& b) {
        if (a.second == b.second) {
            return a.first < b.first;
        }
        return a.second > b.second;
    }
};

class Solution {
public:
    vector<string> topKFrequent(vector<string>& words, int k) {
        unordered_map<string, int> freq;
        for (const string& word : words) {
            freq[word]++;
        }

        priority_queue<pair<string, int>, vector<pair<string, int>>, Compare> pq;
        for (auto const& [word, count] : freq) {
            pq.push({word, count});
            if (pq.size() > k) {
                pq.pop();
            }
        }

        vector<string> result(k);
        for (int i = k - 1; i >= 0; --i) {
            result[i] = pq.top().first;
            pq.pop();
        }

        return result;
    }
};