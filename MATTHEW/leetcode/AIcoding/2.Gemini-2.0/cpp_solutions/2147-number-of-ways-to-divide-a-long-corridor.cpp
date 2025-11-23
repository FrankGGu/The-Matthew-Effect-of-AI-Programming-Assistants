class Solution {
public:
    int numberOfWays(string corridor) {
        int n = corridor.size();
        long long mod = 1e9 + 7;
        vector<int> seats;
        for (int i = 0; i < n; ++i) {
            if (corridor[i] == 'S') {
                seats.push_back(i);
            }
        }

        if (seats.size() < 2 || seats.size() % 2 != 0) {
            return 0;
        }

        long long ans = 1;
        for (int i = 2; i < seats.size(); i += 2) {
            ans = (ans * (seats[i] - seats[i - 1])) % mod;
        }

        return ans;
    }
};