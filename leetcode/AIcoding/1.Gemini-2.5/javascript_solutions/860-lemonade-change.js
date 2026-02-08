var lemonadeChange = function(bills) {
    let fives = 0;
    let tens = 0;

    for (let i = 0; i < bills.length; i++) {
        const bill = bills[i];
        if (bill === 5) {
            fives++;
        } else if (bill === 10) {
            if (fives > 0) {
                fives--;
                tens++;
            } else {
                return false;
            }
        } else { // bill === 20
            if (tens > 0 && fives > 0) {
                tens--;
                fives--;
            } else if (fives >= 3) {
                fives -= 3;
            } else {
                return false;
            }
        }
    }

    return true;
};