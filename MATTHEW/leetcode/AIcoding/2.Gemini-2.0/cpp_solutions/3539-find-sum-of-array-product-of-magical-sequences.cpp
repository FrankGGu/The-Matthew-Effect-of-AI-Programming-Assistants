#include <vector>
#include <algorithm>

using namespace std;

const int MOD = 1e9 + 7;

int magicalString(int n) {
    if (n <= 0) return 0;
    if (n <= 2) return 1;

    string s = "122";
    int ptr1 = 2, ptr2 = 3;

    while (s.length() < n) {
        if (s[ptr1] == '1') {
            s += (s.back() == '1' ? '2' : '1');
        } else {
            s += (s.back() == '1' ? '2' : '1');
            if (s.length() < n) {
                s += (s.back() == '1' ? '2' : '1');
            }
        }
        ptr1++;
    }

    int count = 0;
    for (int i = 0; i < n; ++i) {
        if (s[i] == '1') {
            count++;
        }
    }
    return count;
}

int sumOfArrayProducts(int n) {
    if (n <= 0) return 0;
    if (n == 1) return 1;

    vector<int> arr(n);
    for (int i = 0; i < n; ++i) {
        arr[i] = magicalString(i + 1);
    }

    long long totalSum = 0;
    for (int i = 0; i < (1 << n); ++i) {
        long long currentProduct = 1;
        bool empty = true;

        vector<int> subsequence;
        for (int j = 0; j < n; ++j) {
            if ((i >> j) & 1) {
                subsequence.push_back(arr[j]);
                empty = false;
            }
        }

        if(!empty){
          for(int val : subsequence){
            currentProduct = (currentProduct * val) % MOD;
          }
          totalSum = (totalSum + currentProduct) % MOD;
        }
    }

    return (int)totalSum;
}

```
```cpp
const int MOD = 1e9 + 7;

class Solution {
public:
    int magicalString(int n) {
        if (n <= 0) return 0;
        if (n <= 3) return 1;

        string s = "122";
        int ptr1 = 2, ptr2 = 3;

        while (s.length() < n) {
            if (s[ptr1] == '1') {
                s += (s.back() == '1' ? '2' : '1');
            } else {
                s += (s.back() == '1' ? '2' : '1');
                if (s.length() < n) {
                    s += (s.back() == '1' ? '2' : '1');
                }
            }
            ptr1++;
        }

        int count = 0;
        for (int i = 0; i < n; ++i) {
            if (s[i] == '1') {
                count++;
            }
        }
        return count;
    }

    int sumOfArrayProduct(int n) {
        vector<int> arr(n);
        for (int i = 0; i < n; ++i) {
            arr[i] = magicalString(i + 1);
        }

        long long totalSum = 0;
        for (int i = 1; i < (1 << n); ++i) {
            long long currentProduct = 1;

            for (int j = 0; j < n; ++j) {
                if ((i >> j) & 1) {
                    currentProduct = (currentProduct * arr[j]) % MOD;
                }
            }
            totalSum = (totalSum + currentProduct) % MOD;
        }

        return (int)totalSum;
    }
};