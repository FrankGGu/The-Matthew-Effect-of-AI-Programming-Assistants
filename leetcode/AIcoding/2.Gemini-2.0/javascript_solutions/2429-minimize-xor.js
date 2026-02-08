var minimizeXor = function(num1, num2) {
    let bits2 = 0;
    let temp = num2;
    while (temp > 0) {
        bits2 += (temp & 1);
        temp >>= 1;
    }

    let result = 0;
    let bits1 = [];
    temp = num1;
    for (let i = 0; i < 32; i++) {
        if ((temp & 1) === 1) {
            bits1.push(i);
        }
        temp >>= 1;
    }

    for (let i = bits1.length - 1; i >= 0; i--) {
        if (bits2 > 0) {
            result |= (1 << bits1[i]);
            bits2--;
        }
    }

    if (bits2 > 0) {
        for (let i = 0; i < 32; i++) {
            if (((num1 >> i) & 1) === 0) {
                if (bits2 > 0) {
                    result |= (1 << i);
                    bits2--;
                }
            }
        }
    }

    return result;
};