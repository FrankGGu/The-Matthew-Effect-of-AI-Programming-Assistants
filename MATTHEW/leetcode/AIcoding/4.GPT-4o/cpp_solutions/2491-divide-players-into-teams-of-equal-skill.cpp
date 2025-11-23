class Solution {
public:
    long long dividePlayers(vector<int>& skill) {
        long long totalSkill = accumulate(skill.begin(), skill.end(), 0LL);
        int n = skill.size();
        if (totalSkill % (n / 2) != 0) return -1;
        long long targetSkill = totalSkill / (n / 2);
        sort(skill.begin(), skill.end());
        long long result = 0;
        for (int i = 0; i < n / 2; ++i) {
            if (skill[i] + skill[n - 1 - i] != targetSkill) return -1;
            result += skill[i] * skill[n - 1 - i];
        }
        return result;
    }
};