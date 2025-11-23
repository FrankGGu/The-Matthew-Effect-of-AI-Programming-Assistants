class Solution {
public:
    int countHouses(int d, vector<int>& houses) {
        int count = 0;
        for (int i = 0; i < houses.size(); ++i) {
            if (houses[i] == d) {
                count++;
            }
        }
        return count;
    }
};