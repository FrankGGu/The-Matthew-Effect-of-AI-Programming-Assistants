int distributeMoney(int money, int children) {
    int maxChildren = money / 7;
    if (maxChildren > children) {
        maxChildren = children;
    }
    money -= maxChildren * 7;
    return maxChildren + (money / 3);
}