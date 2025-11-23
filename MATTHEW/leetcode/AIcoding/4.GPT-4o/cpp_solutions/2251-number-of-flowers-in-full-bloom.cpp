class Solution {
public:
    vector<int> numOfFlowersInBloom(vector<vector<int>>& flowers, vector<int>& query) {
        vector<int> result;
        vector<int> bloomCount(1001, 0);

        for (const auto& flower : flowers) {
            for (int day = flower[0]; day <= flower[1]; ++day) {
                bloomCount[day]++;
            }
        }

        for (const auto& day : query) {
            result.push_back(bloomCount[day]);
        }

        return result;
    }
};