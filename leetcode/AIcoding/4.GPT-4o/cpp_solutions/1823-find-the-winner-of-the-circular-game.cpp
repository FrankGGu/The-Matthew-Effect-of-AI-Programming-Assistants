class Solution {
public:
    int findTheWinner(int n, int k) {
        return (findTheWinner(n - 1, k) + k) % n + 1;
    }

    int findTheWinner(int n) {
        return n == 1 ? 1 : (findTheWinner(n - 1) + 1) % n + 1;
    }

    int findTheWinner(int n, int k) {
        return (k == 1) ? n : (findTheWinner(n - 1, k) + k - 1) % n + 1;
    }
};