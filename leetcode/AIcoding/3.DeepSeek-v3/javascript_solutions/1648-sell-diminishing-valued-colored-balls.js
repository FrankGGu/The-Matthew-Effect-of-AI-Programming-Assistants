var maxProfit = function(inventory, orders) {
    inventory.sort((a, b) => b - a);
    inventory.push(0);
    let res = 0;
    let mod = 1e9 + 7;
    let k = 1;

    for (let i = 0; i < inventory.length - 1 && orders > 0; i++) {
        let curr = inventory[i];
        let next = inventory[i + 1];
        let diff = curr - next;
        let count = Math.min(orders, diff * k);
        let full = Math.floor(count / k);
        let remainder = count % k;

        let sumFull = k * (curr + curr - full + 1) * full / 2;
        let sumRemainder = remainder * (curr - full);
        res = (res + sumFull + sumRemainder) % mod;

        orders -= count;
        k++;
    }

    return res;
};