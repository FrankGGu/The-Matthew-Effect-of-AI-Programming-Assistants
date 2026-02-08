class Solution {
public:
    long long dividePlayers(vector<int>& skill) {
        sort(skill.begin(), skill.end());
        int n = skill.size();
        int target = skill[0] + skill[n - 1];
        long long res = skill[0] * skill[n - 1];

        for (int i = 1, j = n - 2; i < j; ++i, --j) {
            if (skill[i] + skill[j] != target) {
                return -1;
            }
            res += skill[i] * skill[j];
        }

        return res;
    }
};