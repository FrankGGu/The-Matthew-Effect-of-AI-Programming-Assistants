class Solution {
public:
    int minimumSum(int n, int k) {
        unordered_set<int> s;
        int sum = 0;
        int num = 1;
        while (s.size() < n) {
            if (s.find(k - num) == s.end()) {
                s.insert(num);
                sum += num;
            }
            num++;
        }
        return sum;
    }
};