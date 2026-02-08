class Solution {
public:
    int maximumDistinctElements(vector<int>& nums) {
        unordered_set<int> distinctElements;
        int n = nums.size();

        for (int num : nums) {
            distinctElements.insert(num);
        }

        int operations = 0;
        while (operations + distinctElements.size() < n) {
            if (distinctElements.count(operations) == 0) {
                operations++;
            } else {
                break;
            }
        }

        return distinctElements.size() + operations;
    }
};