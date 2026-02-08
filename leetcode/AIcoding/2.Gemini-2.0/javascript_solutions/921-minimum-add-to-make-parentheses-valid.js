var minAddToMakeValid = function(s) {
    let balance = 0;
    let count = 0;

    for (let char of s) {
        if (char === '(') {
            balance++;
        } else {
            if (balance > 0) {
                balance--;
            } else {
                count++;
            }
        }
    }

    return count + balance;
};