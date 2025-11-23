var findKthBit = function(n, k) {
    let s = "0";
    for (let i = 2; i <= n; i++) {
        let inverted = s.split('').map(bit => bit === '1' ? '0' : '1').reverse().join('');
        s = s + "1" + inverted;
    }
    return s[k - 1];
};