class Solution {
public:
    int countDistinctIntegers(vector<int>& nums) {
        unordered_set<int> distinct;
        for (int num : nums) {
            distinct.insert(num);
            int reversed = 0;
            while (num > 0) {
                reversed = reversed * 10 + num % 10;
                num /= 10;
            }
            distinct.insert(reversed);
        }
        return distinct.size();
    }
};