var toHex = function(num) {
    if (num === 0) return "0";
    let map = "0123456789abcdef";
    let res = "";
    for (let i = 0; i < 8; i++) {
        let digit = num & 15;
        res = map[digit] + res;
        num >>>= 4;
    }
    while (res[0] === "0" && res.length > 1) {
        res = res.substring(1);
    }
    return res;
};