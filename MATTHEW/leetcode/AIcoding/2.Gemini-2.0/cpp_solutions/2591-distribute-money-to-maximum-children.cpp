class Solution {
public:
    int distMoney(int money, int children) {
        if (money < children) {
            return -1;
        }
        money -= children;
        int ans = min(money / 7, children);
        money -= ans * 7;
        children -= ans;
        if (children == 0) {
            if (money > 0) {
                ans--;
            }
        } else {
            if (children == 1 && money == 3) {
                ans--;
            }
        }
        return ans;
    }
};