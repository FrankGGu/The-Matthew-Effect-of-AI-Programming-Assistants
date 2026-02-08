class Solution {
public:
    int sumFourDivisors(vector<int>& nums) {
        int totalSum = 0;
        for (int num : nums) {
            int count = 0, sum = 0;
            for (int i = 1; i * i <= num; ++i) {
                if (num % i == 0) {
                    if (i == num / i) {
                        count++;
                        sum += i;
                    } else {
                        count += 2;
                        sum += i + num / i;
                    }
                }
                if (count > 4) break;
            }
            if (count == 4) totalSum += sum;
        }
        return totalSum;
    }
};