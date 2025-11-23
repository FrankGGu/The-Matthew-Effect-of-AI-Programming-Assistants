function checkBalanced(s) {
    let balance = 0;
    for (let char of s) {
        if (char === 'L') balance++;
        else if (char === 'R') balance--;
    }
    return balance === 0;
}