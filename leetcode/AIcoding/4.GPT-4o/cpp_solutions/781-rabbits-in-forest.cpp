class Solution {
public:
    int numRabbits(vector<int>& answers) {
        unordered_map<int, int> count;
        for (int answer : answers) {
            count[answer]++;
        }
        int total = 0;
        for (const auto& [answer, freq] : count) {
            total += (freq + answer) / (answer + 1) * (answer + 1);
        }
        return total;
    }
};