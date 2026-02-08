class Solution {
public:
    int numTilePossibilities(string tiles) {
        unordered_map<char, int> count;
        for (char c : tiles) {
            count[c]++;
        }
        return backtrack(count);
    }

private:
    int backtrack(unordered_map<char, int>& count) {
        int sum = 0;
        for (auto& entry : count) {
            if (entry.second > 0) {
                sum++;
                entry.second--;
                sum += backtrack(count);
                entry.second++;
            }
        }
        return sum;
    }
};