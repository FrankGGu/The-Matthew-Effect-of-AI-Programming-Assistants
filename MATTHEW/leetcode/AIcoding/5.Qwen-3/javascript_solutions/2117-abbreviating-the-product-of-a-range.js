function abbreviationProductOfRange(left, right) {
    const MOD = 1000000007;
    const MAX = 1000000000;
    let product = 1;
    let countFive = 0;
    let countTwo = 0;

    for (let i = left; i <= right; i++) {
        let num = i;
        while (num % 5 === 0) {
            countFive++;
            num /= 5;
        }
        while (num % 2 === 0) {
            countTwo++;
            num /= 2;
        }
        product = (product * num) % MOD;
    }

    let expTwo = Math.min(countTwo, countFive);
    countTwo -= expTwo;
    countFive -= expTwo;

    while (countTwo > 0) {
        product = (product * 2) % MOD;
        countTwo--;
    }

    while (countFive > 0) {
        product = (product * 5) % MOD;
        countFive--;
    }

    let result = '';
    if (product === 0) {
        return '0';
    }

    let temp = product;
    let length = 0;
    while (temp > 0) {
        temp = Math.floor(temp / 10);
        length++;
    }

    if (length <= 10) {
        return product.toString();
    } else {
        let first = product;
        let last = product;
        for (let i = 0; i < length - 10; i++) {
            first = Math.floor(first / 10);
        }
        for (let i = 0; i < length - 10; i++) {
            last = Math.floor(last / 10);
        }
        return `${first}...${last}`;
    }
}