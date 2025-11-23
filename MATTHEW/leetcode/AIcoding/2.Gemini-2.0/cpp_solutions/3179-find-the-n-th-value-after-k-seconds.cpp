using namespace std;

class Solution {
public:
    long long findTheNthValue(long long n, long long k) {
        if (n % 2 == 0) {
            return n + 2 * k;
        } else {
            long long rounds = min(k, (n - 1) / 2);
            n += 2 * rounds;
            k -= rounds;
            if (n % 2 == 0) {
                return n + 2 * k;
            } else {
                return n - 2 * k;
            }
        }
    }
};