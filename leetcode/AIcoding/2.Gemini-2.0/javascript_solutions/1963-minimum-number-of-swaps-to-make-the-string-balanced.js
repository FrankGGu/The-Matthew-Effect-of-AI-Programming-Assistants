var minSwaps = function(s) {
    let open = 0;
    for (let i = 0; i < s.length; i++) {
        if (s[i] === '[') {
            open++;
        } else if (open > 0) {
            open--;
        }
    }
    return Math.ceil(open / 2);
};