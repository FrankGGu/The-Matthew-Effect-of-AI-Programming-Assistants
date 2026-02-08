class Solution {
public:
    string findUniqueBinaryString(vector<string>& nums) {
        unordered_set<string> seen(nums.begin(), nums.end());
        string unique;
        for (int i = 0; i < nums.size(); ++i) {
            unique += '0' + (1 - (seen.count(unique + string(1, '0')) ? 0 : 1));
        }
        return unique;
    }
};