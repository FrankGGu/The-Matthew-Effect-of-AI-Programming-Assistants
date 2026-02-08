class Solution {
public:
    vector<int> findErrorNums(vector<int>& nums) {
        unordered_map<int, int> count;
        vector<int> result(2);

        for (int num : nums) {
            count[num]++;
        }

        for (int i = 1; i <= nums.size(); i++) {
            if (count[i] == 2) {
                result[0] = i;
            } else if (count[i] == 0) {
                result[1] = i;
            }
        }

        return result;
    }
};