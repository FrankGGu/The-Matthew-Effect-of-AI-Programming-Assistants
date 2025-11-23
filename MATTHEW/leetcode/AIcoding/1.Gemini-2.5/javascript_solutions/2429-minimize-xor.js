var minimizeXor = function(num1, num2) {
    let k = 0;
    for (let i = 0; i < 31; i++) { 
        if ((num2 >> i) & 1) {
            k++;
        }
    }

    let x = 0;
    for (let i = 30; i >= 0; i--) {
        if (k > 0 && ((num1 >> i) & 1)) {
            x |= (1 << i);
            k--;
        }
    }

    if (k > 0) {
        for (let i = 0; i < 31; i++) {
            if (k > 0 && !((x >> i) & 1)) {
                x |= (1 << i);
                k--;
            }
        }
    }

    return num1 ^ x;
};