class Solution {
public:
    vector<int> groupStrings(vector<string>& words) {
        unordered_map<int, int> freq;
        for (const string& word : words) {
            int mask = 0;
            for (char c : word) {
                mask |= (1 << (c - 'a'));
            }
            freq[mask]++;
        }

        vector<int> res(2);
        unordered_set<int> visited;

        for (const auto& [mask, _] : freq) {
            if (visited.count(mask)) continue;

            queue<int> q;
            q.push(mask);
            visited.insert(mask);
            int groupSize = 0;

            while (!q.empty()) {
                int curr = q.front();
                q.pop();
                groupSize += freq[curr];

                for (int i = 0; i < 26; ++i) {
                    int next = curr ^ (1 << i);
                    if (freq.count(next) && !visited.count(next)) {
                        visited.insert(next);
                        q.push(next);
                    }
                }

                for (int i = 0; i < 26; ++i) {
                    if (curr & (1 << i)) {
                        for (int j = 0; j < 26; ++j) {
                            if (!(curr & (1 << j))) {
                                int next = curr ^ (1 << i) ^ (1 << j);
                                if (freq.count(next) && !visited.count(next)) {
                                    visited.insert(next);
                                    q.push(next);
                                }
                            }
                        }
                    }
                }
            }

            res[0]++;
            res[1] = max(res[1], groupSize);
        }

        return res;
    }
};