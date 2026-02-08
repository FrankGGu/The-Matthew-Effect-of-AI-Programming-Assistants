class Solution {
public:
    int findMinMoves(vector<int>& machines) {
        int total = accumulate(machines.begin(), machines.end(), 0);
        int n = machines.size();
        if (total % n != 0) return -1;
        int avg = total / n;
        int res = 0, sum = 0;
        for (int num : machines) {
            num -= avg;
            sum += num;
            res = max(res, max(abs(sum), num));
        }
        return res;
    }
};