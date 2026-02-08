class Solution {
public:
    int maxItems(vector<int>& price, int k) {
        sort(price.begin(), price.end());
        int count = 0;
        for (int p : price) {
            if (k >= p) {
                k -= p;
                count++;
            } else {
                break;
            }
        }
        return count;
    }
};