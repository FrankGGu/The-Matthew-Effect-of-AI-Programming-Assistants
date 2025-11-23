class Solution {
public:
    long long makeSimilar(vector<int>& nums, vector<int>& target) {
        vector<int> evenNums, oddNums;
        vector<int> evenTarget, oddTarget;

        for (int num : nums) {
            if (num % 2 == 0) evenNums.push_back(num);
            else oddNums.push_back(num);
        }

        for (int num : target) {
            if (num % 2 == 0) evenTarget.push_back(num);
            else oddTarget.push_back(num);
        }

        sort(evenNums.begin(), evenNums.end());
        sort(oddNums.begin(), oddNums.end());
        sort(evenTarget.begin(), evenTarget.end());
        sort(oddTarget.begin(), oddTarget.end());

        long long res = 0;

        for (int i = 0; i < evenNums.size(); ++i) {
            res += abs(evenNums[i] - evenTarget[i]) / 2;
        }

        for (int i = 0; i < oddNums.size(); ++i) {
            res += abs(oddNums[i] - oddTarget[i]) / 2;
        }

        return res / 2;
    }
};