function moneyExchange(money, children) {
    if (money < children) return 0;
    let max = Math.min(Math.floor(money / children), 1);
    return max;
}