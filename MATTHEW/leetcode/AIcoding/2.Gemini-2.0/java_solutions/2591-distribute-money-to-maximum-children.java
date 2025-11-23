class Solution {
    public int distMoney(int money, int children) {
        if (money < children) {
            return -1;
        }

        money -= children;

        int count = money / 7;
        money %= 7;

        count = Math.min(count, children);

        children -= count;

        if (children == 0) {
            if (money > 0) {
                if (money == 3 && count > 0) {
                    count--;
                }
            }
        } else {
            if (money == 3 && children == 1) {
                count--;
            }
        }

        return count;
    }
}