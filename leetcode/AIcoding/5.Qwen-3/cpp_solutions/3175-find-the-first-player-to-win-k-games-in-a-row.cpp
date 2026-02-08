#include <iostream>
#include <vector>

using namespace std;

class Solution {
public:
    int kGames(vector<int>& score, int k) {
        int n = score.size();
        int currentStreak = 0;
        for (int i = 0; i < n; ++i) {
            if (score[i] > score[i - 1]) {
                currentStreak++;
            } else {
                currentStreak = 1;
            }
            if (currentStreak >= k) {
                return i;
            }
        }
        return -1;
    }
};