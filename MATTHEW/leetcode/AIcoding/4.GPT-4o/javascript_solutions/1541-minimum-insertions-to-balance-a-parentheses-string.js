var minInsertions = function(s) {
    let balance = 0, insertions = 0;
    for (let i = 0; i < s.length; i++) {
        if (s[i] === '(') {
            balance += 2;
            if (balance % 2 === 1) {
                insertions++;
                balance--;
            }
        } else {
            balance--;
            if (balance < 0) {
                insertions++;
                balance = 0;
            }
        }
    }
    return insertions + balance;
};