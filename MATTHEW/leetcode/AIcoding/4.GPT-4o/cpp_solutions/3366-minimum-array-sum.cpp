class Solution {
public:
    int minArraySum(vector<int>& numbers) {
        return accumulate(numbers.begin(), numbers.end(), 0);
    }
};