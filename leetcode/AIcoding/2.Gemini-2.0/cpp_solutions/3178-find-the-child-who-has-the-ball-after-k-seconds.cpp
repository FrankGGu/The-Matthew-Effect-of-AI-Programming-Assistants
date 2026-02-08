class Solution {
public:
    int findTheWinner(int n, int k) {
        int pos = 0;
        vector<int> players(n);
        for (int i = 0; i < n; ++i) {
            players[i] = i + 1;
        }

        while (players.size() > 1) {
            pos = (pos + k - 1) % players.size();
            players.erase(players.begin() + pos);
        }

        return players[0];
    }
};
```
```cpp
class Solution {
public:
    int findTheWinner(int n, int k) {
        int winner = 1;
        for (int i = 2; i <= n; ++i) {
            winner = (winner + k - 1) % i + 1;
        }
        return winner;
    }
};
```
```cpp
class Solution {
public:
    int findTheWinner(int n, int k) {
        return (josephus(n, k) + 1);
    }

private:
    int josephus(int n, int k) {
        if (n == 1) {
            return 0;
        }
        return (josephus(n - 1, k) + k) % n;
    }
};