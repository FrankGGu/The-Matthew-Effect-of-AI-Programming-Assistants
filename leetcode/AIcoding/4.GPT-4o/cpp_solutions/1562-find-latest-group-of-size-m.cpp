class Solution {
public:
    vector<int> findLatestGroup(vector<int>& grades, int m) {
        unordered_map<int, int> count;
        for (int grade : grades) {
            count[grade]++;
        }

        vector<int> result;
        for (const auto& [grade, cnt] : count) {
            if (cnt == m) {
                result.push_back(grade);
            }
        }

        sort(result.begin(), result.end());
        return result;
    }
};