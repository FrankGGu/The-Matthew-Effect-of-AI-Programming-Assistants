class Solution {
public:
    int lastRemaining(int n, int m) {
        int ans = 0;
        // The Josephus problem can be solved using a recurrence relation:
        // f(n, m) represents the survivor's index (0-indexed) for n people and step m.
        // Base case: f(1, m) = 0 (when only one person remains, they are the survivor, at index 0).
        // Recurrence: f(i, m) = (f(i-1, m) + m) % i
        // We iterate from i = 2 up to n to build the solution.
        for (int i = 2; i <= n; ++i) {
            ans = (ans + m) % i;
        }
        return ans;
    }
};