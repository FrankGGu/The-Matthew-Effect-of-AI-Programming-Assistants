class Solution {
public:
    vector<int> findOriginalArray(vector<int>& changed) {
        if (changed.size() % 2 != 0) return {};

        unordered_map<int, int> freq;
        for (int num : changed) {
            freq[num]++;
        }

        vector<int> keys;
        for (auto& pair : freq) {
            keys.push_back(pair.first);
        }
        sort(keys.begin(), keys.end());

        vector<int> original;
        for (int num : keys) {
            if (freq[num] == 0) continue;
            if (num == 0) {
                if (freq[num] % 2 != 0) return {};
                int count = freq[num] / 2;
                for (int i = 0; i < count; ++i) {
                    original.push_back(num);
                }
                freq[num] = 0;
            } else {
                int doubled = num * 2;
                if (freq.find(doubled) == freq.end() || freq[doubled] < freq[num]) {
                    return {};
                }
                for (int i = 0; i < freq[num]; ++i) {
                    original.push_back(num);
                }
                freq[doubled] -= freq[num];
                freq[num] = 0;
            }
        }

        return original;
    }
};