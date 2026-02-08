class Solution {
public:
    int distinctElementSumOfSquares(vector<int>& nums) {
        unordered_set<int> distinctElements;
        int sumOfSquares = 0;

        for (int num : nums) {
            if (distinctElements.find(num) == distinctElements.end()) {
                distinctElements.insert(num);
                sumOfSquares += num * num;
            }
        }

        return sumOfSquares;
    }
};