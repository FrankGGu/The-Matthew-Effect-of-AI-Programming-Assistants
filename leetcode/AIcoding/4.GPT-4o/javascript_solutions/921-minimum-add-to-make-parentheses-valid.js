var minAddToMakeValid = function(S) {
    let balance = 0;
    let addCount = 0;

    for (let char of S) {
        if (char === '(') {
            balance++;
        } else if (char === ')') {
            if (balance > 0) {
                balance--;
            } else {
                addCount++;
            }
        }
    }

    return addCount + balance;
};