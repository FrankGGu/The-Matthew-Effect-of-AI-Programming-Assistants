class Solution {
public:
    bool canThreePartsEqualSum(vector<int>& arr) {
        int total = accumulate(arr.begin(), arr.end(), 0);
        if (total % 3 != 0) return false;
        int target = total / 3;
        int sum = 0, count = 0;
        for (int num : arr) {
            sum += num;
            if (sum == target) {
                count++;
                sum = 0;
            }
        }
        return count >= 3;
    }
};