class Solution {
public:
    string findChampion(string winner, string loser) {
        unordered_map<string, int> score;
        score[winner]++;
        score[loser]--;

        string champion;
        int maxScore = INT_MIN;

        for (const auto& entry : score) {
            if (entry.second > maxScore) {
                maxScore = entry.second;
                champion = entry.first;
            }
        }

        return champion;
    }
};