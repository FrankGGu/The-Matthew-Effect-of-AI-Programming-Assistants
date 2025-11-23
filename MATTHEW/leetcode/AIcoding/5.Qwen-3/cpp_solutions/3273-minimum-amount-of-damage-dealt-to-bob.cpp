#include <iostream>
#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int minimumDamage(int power, vector<int> &attackerDamage, vector<int> &attackerHealth) {
        int n = attackerDamage.size();
        vector<pair<int, int>> attacks(n);

        for (int i = 0; i < n; ++i) {
            attacks[i] = {attackerDamage[i], attackerHealth[i]};
        }

        sort(attacks.begin(), attacks.end(), [](const pair<int, int>& a, const pair<int, int>& b) {
            return a.first * b.second > b.first * a.second;
        });

        int totalDamage = 0;
        for (const auto& [dmg, hp] : attacks) {
            int hits = (hp + power - 1) / power;
            totalDamage += dmg * hits;
        }

        return totalDamage;
    }
};