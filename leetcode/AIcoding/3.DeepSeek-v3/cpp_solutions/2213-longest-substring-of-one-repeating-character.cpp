class Solution {
public:
    vector<int> longestRepeating(string s, string queryCharacters, vector<int>& queryIndices) {
        int n = s.size();
        int m = queryCharacters.size();
        vector<int> res(m);
        vector<pair<char, int>> segments;

        for (int i = 0; i < n; ) {
            int j = i;
            while (j < n && s[j] == s[i]) j++;
            segments.emplace_back(s[i], j - i);
            i = j;
        }

        multiset<int> lengths;
        for (auto& seg : segments) {
            lengths.insert(seg.second);
        }

        for (int k = 0; k < m; ++k) {
            char c = queryCharacters[k];
            int idx = queryIndices[k];
            if (s[idx] == c) {
                res[k] = *lengths.rbegin();
                continue;
            }
            s[idx] = c;

            int seg_idx = 0;
            int pos = 0;
            for (; seg_idx < segments.size(); ++seg_idx) {
                if (pos + segments[seg_idx].second > idx) break;
                pos += segments[seg_idx].second;
            }

            auto it = lengths.find(segments[seg_idx].second);
            lengths.erase(it);

            char old_char = segments[seg_idx].first;
            int old_len = segments[seg_idx].second;
            int left_len = idx - pos;
            int right_len = pos + old_len - idx - 1;

            vector<pair<char, int>> new_segments;
            if (left_len > 0) {
                new_segments.emplace_back(old_char, left_len);
                lengths.insert(left_len);
            }
            new_segments.emplace_back(c, 1);
            lengths.insert(1);
            if (right_len > 0) {
                new_segments.emplace_back(old_char, right_len);
                lengths.insert(right_len);
            }

            segments.erase(segments.begin() + seg_idx);
            segments.insert(segments.begin() + seg_idx, new_segments.begin(), new_segments.end());

            for (int i = max(0, seg_idx - 1); i <= min(seg_idx + 1, (int)segments.size() - 1); ++i) {
                if (i > 0 && segments[i].first == segments[i - 1].first) {
                    auto it1 = lengths.find(segments[i].second);
                    lengths.erase(it1);
                    auto it2 = lengths.find(segments[i - 1].second);
                    lengths.erase(it2);

                    segments[i - 1].second += segments[i].second;
                    lengths.insert(segments[i - 1].second);

                    segments.erase(segments.begin() + i);
                    i--;
                }
            }

            res[k] = *lengths.rbegin();
        }

        return res;
    }
};