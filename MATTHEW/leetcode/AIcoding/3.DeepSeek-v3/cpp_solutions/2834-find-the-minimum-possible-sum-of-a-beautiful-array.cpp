class Solution {
public:
    long long minimumPossibleSum(int n, int target) {
        unordered_set<int> used;
        long long sum = 0;
        int num = 1;
        while (used.size() < n) {
            if (used.find(target - num) == used.end()) {
                used.insert(num);
                sum += num;
            }
            num++;
        }
        return sum;
    }
};