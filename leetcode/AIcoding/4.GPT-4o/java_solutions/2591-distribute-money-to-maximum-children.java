class Solution {
    public int distributeMoney(int money, int children) {
        int maxDistributable = Math.min(money / 3, children);
        money -= maxDistributable * 3;
        children -= maxDistributable;

        return children == 0 ? 0 : Math.min(money, children);
    }
}