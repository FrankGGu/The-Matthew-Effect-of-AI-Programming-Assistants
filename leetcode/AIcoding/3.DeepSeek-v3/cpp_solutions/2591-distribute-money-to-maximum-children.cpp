class Solution {
public:
    int distMoney(int money, int children) {
        if (money < children) {
            return -1;
        }
        money -= children;
        int count = money / 7;
        int remaining = money % 7;
        if (count > children) {
            return children - 1;
        }
        if (count == children) {
            return remaining == 0 ? count : count - 1;
        }
        if (remaining == 3 && count == children - 1) {
            return count - 1;
        }
        return count;
    }
};