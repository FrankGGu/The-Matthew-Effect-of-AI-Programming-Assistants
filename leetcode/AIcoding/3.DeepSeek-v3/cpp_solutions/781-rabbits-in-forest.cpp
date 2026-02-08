class Solution {
public:
    int numRabbits(vector<int>& answers) {
        unordered_map<int, int> count;
        for (int num : answers) {
            count[num]++;
        }
        int res = 0;
        for (auto& [num, cnt] : count) {
            res += (cnt + num) / (num + 1) * (num + 1);
        }
        return res;
    }
};