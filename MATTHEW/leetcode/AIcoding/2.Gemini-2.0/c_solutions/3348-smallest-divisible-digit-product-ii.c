#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef long long ll;

char* smallestGoodBase(ll n) {
    for (int k = 60; k >= 2; --k) {
        ll low = 2, high = n - 1;
        while (low <= high) {
            ll mid = low + (high - low) / 2;
            ll sum = 0, term = 1;
            int overflow = 0;
            for (int i = 0; i < k; ++i) {
                if (sum > n) {
                    overflow = 1;
                    break;
                }
                if (sum > n - term) {
                    overflow = 1;
                    break;
                }

                sum += term;
                if (i < k - 1) {
                   if (term > (n / mid)) {
                       overflow = 1;
                       break;
                   }
                   term *= mid;
                }
            }

            if (overflow == 1 || sum > n) {
                high = mid - 1;
            } else if (sum < n) {
                low = mid + 1;
            } else {
                char* res = (char*)malloc(25 * sizeof(char));
                sprintf(res, "%lld", mid);
                return res;
            }
        }
    }

    char* res = (char*)malloc(25 * sizeof(char));
    sprintf(res, "%lld", n - 1);
    return res;
}