class Solution {
    public int distributeMoney(int money, int children) {
        if (money < children) {
            return 0;
        }

        int maxEights = money / 8;

        if (maxEights >= children) {
            if (money == children * 8) {
                return children;
            }
            return children - 1;
        }

        int remainingChildren = children - maxEights;
        int remainingMoney = money - maxEights * 8;

        if (remainingMoney < remainingChildren) {
            return (money - children) / 7;
        }

        if (remainingChildren == 1 && remainingMoney == 4) {
            return maxEights - 1;
        }

        return maxEights;
    }
}