class Solution {
public:
    int minSetSize(vector<int>& arr) {
        unordered_map<int, int> count;
        for (int num : arr) {
            count[num]++;
        }

        vector<int> freq;
        for (auto& [_, c] : count) {
            freq.push_back(c);
        }

        sort(freq.rbegin(), freq.rend());

        int removed = 0, sets = 0;
        for (int f : freq) {
            removed += f;
            sets++;
            if (removed >= arr.size() / 2) {
                break;
            }
        }

        return sets;
    }
};