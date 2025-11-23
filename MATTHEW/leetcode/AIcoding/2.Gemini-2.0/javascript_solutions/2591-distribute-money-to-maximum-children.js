var distMoney = function(money, children) {
    if (money < children) {
        return -1;
    }
    money -= children;
    let count = Math.min(Math.floor(money / 7), children);
    money -= count * 7;
    children -= count;
    if (children === 0) {
        if (money > 0) {
            count--;
        }
    } else {
        if (children === 1 && money === 3) {
            count--;
        }
    }
    return count;
};