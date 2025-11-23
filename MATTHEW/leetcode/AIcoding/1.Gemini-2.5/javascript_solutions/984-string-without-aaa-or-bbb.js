var strWithout3a3b = function(a, b) {
    let res = [];

    while (a > 0 || b > 0) {
        let endsWithAA = (res.length >= 2 && res[res.length - 1] === 'a' && res[res.length - 2] === 'a');
        let endsWithBB = (res.length >= 2 && res[res.length - 1] === 'b' && res[res.length - 2] === 'b');

        let writeA = false;
        let writeB = false;

        if (a >= b) { // Prioritize 'a' if 'a' count is greater or equal
            if (a > 0 && !endsWithAA) {
                writeA = true;
            } else { // Must write 'b' to avoid 'aaa' or if 'a' count is 0
                writeB = true;
            }
        } else { // Prioritize 'b' if 'b' count is greater
            if (b > 0 && !endsWithBB) {
                writeB = true;
            } else { // Must write 'a' to avoid 'bbb' or if 'b' count is 0
                writeA = true;
            }
        }

        if (writeA) {
            res.push('a');
            a--;
        } else if (writeB) {
            res.push('b');
            b--;
        }
        // The problem guarantees a solution always exists, so one of writeA or writeB will always lead to a valid character to append.
    }

    return res.join('');
};