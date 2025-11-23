#include <vector>
#include <algorithm>

using namespace std;

typedef long long ll;

ll convert(ll n, ll k) {
    ll res = 0;
    ll p = 1;
    while (n > 0) {
        res += (n % k) * p;
        p *= 10;
        n /= k;
    }
    return res;
}

bool isPalindrome(ll n, int k) {
    ll converted = convert(n, k);
    string s = to_string(converted);
    string t = s;
    reverse(t.begin(), t.end());
    return s == t;
}

ll constructPalindrome(ll num, bool odd, int k) {
    string s = to_string(num);
    string t = s;
    if (odd) {
        s.pop_back();
    }
    reverse(s.begin(), s.end());
    t += s;
    try {
        return stoll(t);
    } catch (out_of_range& e) {
        return -1;
    }
}

ll kMirror(int k, int n) {
    ll sum = 0;
    int count = 0;
    ll i = 1;
    while (count < n) {
        for (int odd = 0; odd <= 1; ++odd) {
            ll palindrome = constructPalindrome(i, odd, k);
            if (palindrome != -1 && isPalindrome(palindrome, k)) {
                string s = to_string(palindrome);
                bool is_dec_palindrome = true;
                string t = s;
                reverse(t.begin(), t.end());
                if (t != s) {
                    is_dec_palindrome = false;
                }
                if (is_dec_palindrome) {
                    sum += palindrome;
                    count++;
                    if (count == n) break;
                }
            }
        }
        i++;
    }
    return sum;
}