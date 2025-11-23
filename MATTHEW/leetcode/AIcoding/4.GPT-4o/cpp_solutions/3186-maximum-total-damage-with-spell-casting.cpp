class Solution {
public:
    int maximumDamage(vector<int>& damage, vector<int>& spell, int armor) {
        int totalDamage = accumulate(damage.begin(), damage.end(), 0);
        int maxSpellDamage = *max_element(spell.begin(), spell.end());
        int reducedDamage = min(armor, maxSpellDamage);
        return totalDamage + maxSpellDamage - reducedDamage;
    }
};