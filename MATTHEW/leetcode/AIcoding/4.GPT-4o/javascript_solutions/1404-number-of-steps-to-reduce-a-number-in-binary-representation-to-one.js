var numSteps = function(s) {
    let steps = 0;
    let carry = 0;

    for (let i = s.length - 1; i > 0; i--) {
        if (s[i] === '1') {
            steps += 2; // one for the addition, one for the division
            if (carry) steps++; // if there's a carry, we need an extra step
            carry = 1; // we will have a carry from the addition
        } else {
            steps++; // just the division step
        }
    }

    return steps + carry; // add the final step if there's a carry
};