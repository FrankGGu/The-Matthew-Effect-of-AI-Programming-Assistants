#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int maxProfit(vector<int>& inventory, int orders) {
        sort(inventory.begin(), inventory.end());
        long long ans = 0;
        int mod = 1e9 + 7;
        int n = inventory.size();
        while (orders > 0) {
            int maxVal = inventory[n - 1];
            int nextMax = (n > 1) ? inventory[n - 2] : 0;
            int diff = maxVal - nextMax;
            long long count = 0;
            if (orders / diff >= 1) {
                count = min((long long)orders / diff, (long long)n);
            }

            if (count * diff >= orders) {
                count = (long long)orders / n;
                if (orders % n != 0)
                    count++;
                diff = (orders + n - 1) / n;
                long long endVal = maxVal - diff + 1;
                ans = (ans + (((long long)maxVal + endVal) * diff / 2 % mod) * n % mod) % mod;
                orders -= diff * n;
                for (int i = 0; i < n; i++) {
                    inventory[i] -= diff;
                    if (inventory[i] < 0)
                        inventory[i] = 0;
                }
                break;
            }

            if(count * diff < orders) {
                long long num = n;
                long long endVal = maxVal - diff + 1;
                ans = (ans + (((long long)maxVal + endVal) * diff / 2 % mod) * num % mod) % mod;
                orders -= diff * n;
                for (int i = 0; i < n; i++)
                    inventory[i] -= diff;
            }
            else {

            }

            if (orders > 0) {
                long long num = 0;
                if (inventory[n-1] > 0) {
                    num = 0;
                }
                for(int i = 0; i < n; ++i) {
                  if (inventory[i] == maxVal) {
                    num++;
                  }
                }
                long long take = min((long long)orders, num);
                ans = (ans + ((long long)maxVal * take % mod)) % mod;
                orders -= take;

                for (int i = 0; i < n; ++i) {
                  if (inventory[i] == maxVal) {
                    inventory[i]--;
                  }
                  if (orders == 0) break;
                }
            }
            sort(inventory.begin(), inventory.end());
        }
        return (int)ans;
    }
};