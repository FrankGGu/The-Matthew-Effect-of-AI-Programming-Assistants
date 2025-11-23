#include <iostream>
#include <vector>
#include <unordered_map>

using namespace std;

class Solution {
public:
    long long dividePlayers(int n, vector<int>& skill) {
        unordered_map<int, int> freq;
        for (int s : skill) {
            freq[s]++;
        }
        long long total = 0;
        for (int s : skill) {
            int target = skill[0] + skill.back();
            if (freq.find(s) == freq.end()) continue;
            if (freq.find(target - s) == freq.end()) return -1;
            if (s == target - s) {
                if (freq[s] < 2) return -1;
                total += (long long)s * (target - s);
                freq[s] -= 2;
                if (freq[s] == 0) freq.erase(s);
            } else {
                if (freq[s] == 0 || freq[target - s] == 0) return -1;
                total += (long long)s * (target - s);
                freq[s]--;
                freq[target - s]--;
                if (freq[s] == 0) freq.erase(s);
                if (freq[target - s] == 0) freq.erase(target - s);
            }
        }
        return total;
    }
};