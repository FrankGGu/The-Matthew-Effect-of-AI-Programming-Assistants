class Solution {
public:
    vector<int> sortByBits(vector<int>& arr) {
        auto countBits = [](int num) {
            int count = 0;
            while (num) {
                count += num & 1;
                num >>= 1;
            }
            return count;
        };

        sort(arr.begin(), arr.end(), [&countBits](int a, int b) {
            int countA = countBits(a);
            int countB = countBits(b);
            if (countA == countB) {
                return a < b;
            }
            return countA < countB;
        });

        return arr;
    }
};