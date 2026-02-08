#include <string>
#include <algorithm>
#include <cmath>

using namespace std;

bool isPalindrome(int n) {
    string s = to_string(n);
    string rs = s;
    reverse(rs.begin(), rs.end());
    return s == rs;
}

bool isPrime(int n) {
    if (n <= 1) return false;
    for (int i = 2; i * i <= n; i++) {
        if (n % i == 0) return false;
    }
    return true;
}

int primePalindrome(int n) {
    if (n <= 2) return 2;

    while (true) {
        if (n > 10000000 && n < 100000000)
            n = 100000001;

        if (isPalindrome(n) && isPrime(n)) {
            return n;
        }
        n++;
    }
}