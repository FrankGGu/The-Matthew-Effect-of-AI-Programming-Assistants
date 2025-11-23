class Solution {
public:
    int inventoryManagement(vector<int>& stock) {
        int candidate = -1;
        int count = 0;
        for (int num : stock) {
            if (count == 0) {
                candidate = num;
                count = 1;
            } else {
                if (num == candidate) {
                    count++;
                } else {
                    count--;
                }
            }
        }
        count = 0;
        for (int num : stock) {
            if (num == candidate) {
                count++;
            }
        }
        return count > stock.size() / 2 ? candidate : -1;
    }
};