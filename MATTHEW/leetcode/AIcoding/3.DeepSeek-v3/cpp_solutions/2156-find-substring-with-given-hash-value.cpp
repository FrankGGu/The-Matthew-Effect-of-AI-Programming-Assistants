class Solution {
public:
    string subStrHash(string s, int power, int modulo, int k, int hashValue) {
        int n = s.size();
        long long current_hash = 0;
        long long power_k = 1;

        for (int i = n - k; i < n; ++i) {
            current_hash = (current_hash * power + (s[i] - 'a' + 1)) % modulo;
            if (i != n - k) {
                power_k = (power_k * power) % modulo;
            }
        }

        int result = -1;
        if (current_hash == hashValue) {
            result = n - k;
        }

        for (int i = n - k - 1; i >= 0; --i) {
            current_hash = (current_hash - (s[i + k] - 'a' + 1) * power_k % modulo + modulo) % modulo;
            current_hash = (current_hash * power + (s[i] - 'a' + 1)) % modulo;
            if (current_hash == hashValue) {
                result = i;
            }
        }

        return s.substr(result, k);
    }
};