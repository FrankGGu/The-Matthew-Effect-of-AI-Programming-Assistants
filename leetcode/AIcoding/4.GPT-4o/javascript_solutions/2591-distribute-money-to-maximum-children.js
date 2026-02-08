var distributeMoney = function(money, children) {
    let maxChildren = Math.min(children, Math.floor(money / 2));
    money -= maxChildren * 2;
    return maxChildren + Math.min(money, children - maxChildren);
};