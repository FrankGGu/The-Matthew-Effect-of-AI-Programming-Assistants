class Solution {
public:
    vector<int> successfulPairs(vector<int>& spells, vector<int>& potions, long long success) {
        sort(potions.begin(), potions.end());
        vector<int> res;
        int n = potions.size();
        for (long long spell : spells) {
            long long target = (success + spell - 1) / spell;
            auto it = lower_bound(potions.begin(), potions.end(), target);
            res.push_back(potions.end() - it);
        }
        return res;
    }
};