class Solution {
public:
    int countDistinctIntegers(vector<int>& nums) {
        set<int> distinct;
        for (int num : nums) {
            distinct.insert(num);
            string strNum = to_string(num);
            reverse(strNum.begin(), strNum.end());
            distinct.insert(stoi(strNum));
        }
        return distinct.size();
    }
};