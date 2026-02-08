var sumOfNumberAndItsReverse = function(num) {
    const reverse = (n) => {
        let reversedN = 0;
        let temp = n;
        while (temp > 0) {
            let digit = temp % 10;
            reversedN = reversedN * 10 + digit;
            temp = Math.floor(temp / 10);
        }
        return reversedN;
    };

    for (let x = 0; x <= num; x++) {
        if (x + reverse(x) === num) {
            return true;
        }
    }

    return false;
};