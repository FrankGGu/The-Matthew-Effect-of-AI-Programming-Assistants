class Solution {
public:
    int distMoney(int money, int children) {
        if (money < children) return -1;
        money -= children;
        if (money == 0) return 0;
        int bundles = money / 7;
        money %= 7;
        while (bundles >= 0) {
            if (money == 0) return bundles;
            if (money == 3 && bundles > 0) return bundles - 1;
            if (money < 7) return bundles;
            bundles--;
            money += 7;
        }
        return -1;
    }
};