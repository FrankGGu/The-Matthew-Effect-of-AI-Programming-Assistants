public class Solution {
    public int distMoney(int money, int children) {
        if (children > money) return 0;
        if (children == 1) return money >= 1 ? 1 : 0;

        int[] childrenMoney = new int[children];
        for (int i = 0; i < children; i++) {
            childrenMoney[i] = 1;
        }
        money -= children;

        for (int i = 0; i < children && money > 0; i++) {
            int add = Math.min(money, 8);
            childrenMoney[i] += add;
            money -= add;
        }

        int count = 0;
        for (int i = 0; i < children; i++) {
            if (childrenMoney[i] == 1) {
                count++;
            }
        }

        return count;
    }
}