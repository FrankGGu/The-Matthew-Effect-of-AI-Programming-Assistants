class Solution {
public:
    int findMinMoves(vector<int>& machines) {
        int total = accumulate(machines.begin(), machines.end(), 0);
        int n = machines.size();
        if (total % n != 0) return -1;
        int target = total / n;
        int maxMoves = 0, currSum = 0;

        for (int i = 0; i < n; ++i) {
            currSum += machines[i] - target;
            maxMoves = max(maxMoves, abs(currSum));
            maxMoves = max(maxMoves, machines[i] - target);
        }

        return maxMoves;
    }
};