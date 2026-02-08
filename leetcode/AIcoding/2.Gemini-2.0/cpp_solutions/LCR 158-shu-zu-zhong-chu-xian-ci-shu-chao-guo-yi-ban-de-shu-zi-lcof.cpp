#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int findLeastValuable(int m, vector<int>& inventory) {
        sort(inventory.begin(), inventory.end(), greater<int>());
        long long ans = 0;
        int mod = 1e9 + 7;
        int i = 0;
        while (m > 0) {
            if (i + 1 < inventory.size() && inventory[i + 1] == inventory[i]) {
                i++;
                continue;
            }
            int nextVal = (i + 1 < inventory.size()) ? inventory[i + 1] : 0;
            int diff = inventory[i] - nextVal;
            int count = i + 1;
            long long numToRemove = min((long long)m, (long long)diff * count);
            long long numFullRows = numToRemove / count;
            long long numPartialRow = numToRemove % count;
            long long start = inventory[i];
            long long end = inventory[i] - numFullRows + 1;
            ans = (ans + (start + end) * numFullRows / 2 % mod * count % mod) % mod;
            ans = (ans + (start - numFullRows) * numPartialRow % mod) % mod;
            m -= numToRemove;
            inventory[i] -= numFullRows;
            if(i + 1 < inventory.size() && inventory[i] < inventory[i+1]){
                sort(inventory.begin(), inventory.end(), greater<int>());
            }
        }
        return (int)ans;
    }
};