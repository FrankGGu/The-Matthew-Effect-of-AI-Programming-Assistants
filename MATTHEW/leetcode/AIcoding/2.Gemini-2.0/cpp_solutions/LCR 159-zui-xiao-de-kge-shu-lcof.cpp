#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int minimumBoxes(int n) {
        int k = 1;
        while (k * (k + 1) * (k + 2) / 6 <= n) {
            k++;
        }
        k--;
        n -= k * (k + 1) * (k + 2) / 6;
        int res = k * (k + 1) / 2;
        int l = 1;
        while (l * (l + 1) / 2 <= n) {
            l++;
        }
        l--;
        res += l * (l + 1) / 2 > 0 ? l * (l + 1) / 2 : 0;
        if (l * (l + 1) / 2 < n) {
            res += n - l * (l + 1) / 2 > 0 ? 1 : 0;
        }
        int temp = 0;
        int i = 1;
        while(temp < n){
            temp += i;
            i++;
        }
        return k * (k + 1) / 2 + i - 1;

    }
};