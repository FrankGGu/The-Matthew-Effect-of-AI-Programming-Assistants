class Solution {
public:
    bool equalFrequency(string word) {
        vector<int> freq(26, 0);
        for (char c : word) {
            freq[c - 'a']++;
        }

        unordered_map<int, int> count;
        for (int f : freq) {
            if (f > 0) count[f]++;
        }

        if (count.size() == 1) return true;
        if (count.size() == 2) {
            auto it = count.begin();
            int f1 = it->first, c1 = it->second;
            it++;
            int f2 = it->first, c2 = it->second;
            return (c1 == 1 && (f1 == 1 || f1 - f2 == 1)) || (c2 == 1 && (f2 == 1 || f2 - f1 == 1));
        }

        return false;
    }
};