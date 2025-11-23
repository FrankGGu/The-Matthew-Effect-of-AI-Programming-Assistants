class Solution {
public:
    vector<string> topKFrequent(vector<string>& words, int k) {
        unordered_map<string, int> freq;
        for (const auto& word : words) {
            freq[word]++;
        }

        auto cmp = [](const pair<string, int>& a, const pair<string, int>& b) {
            return a.second > b.second || (a.second == b.second && a.first < b.first);
        };

        priority_queue<pair<string, int>, vector<pair<string, int>>, decltype(cmp)> pq(cmp);

        for (const auto& entry : freq) {
            pq.push(entry);
            if (pq.size() > k) {
                pq.pop();
            }
        }

        vector<string> result;
        while (!pq.empty()) {
            result.push_back(pq.top().first);
            pq.pop();
        }
        reverse(result.begin(), result.end());
        return result;
    }
};