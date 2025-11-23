var maxmiumScore = function(cards, cnt) {
    let odd = [];
    let even = [];
    for (let card of cards) {
        if (card % 2 === 0) {
            even.push(card);
        } else {
            odd.push(card);
        }
    }
    odd.sort((a, b) => b - a);
    even.sort((a, b) => b - a);

    let prefixOdd = new Array(odd.length + 1).fill(0);
    let prefixEven = new Array(even.length + 1).fill(0);
    for (let i = 1; i <= odd.length; i++) {
        prefixOdd[i] = prefixOdd[i - 1] + odd[i - 1];
    }
    for (let i = 1; i <= even.length; i++) {
        prefixEven[i] = prefixEven[i - 1] + even[i - 1];
    }

    let res = 0;
    for (let k = 0; k <= Math.min(cnt, odd.length); k += 2) {
        if (cnt - k >= 0 && cnt - k <= even.length) {
            res = Math.max(res, prefixOdd[k] + prefixEven[cnt - k]);
        }
    }
    return res;
};