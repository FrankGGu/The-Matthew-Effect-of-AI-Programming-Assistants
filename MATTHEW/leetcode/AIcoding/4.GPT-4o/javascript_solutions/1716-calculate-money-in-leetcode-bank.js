var totalMoney = function(n) {
    const weeks = Math.floor(n / 7);
    const days = n % 7;
    return (weeks * (28 + (weeks - 1) * 7)) / 2 + (days * (days + 1)) / 2 + weeks * days;
};