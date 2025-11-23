function countSpecialSubsequences(s) {
    let a = 0, ab = 0, abc = 0;
    for (let c of s) {
        if (c === 'a') a++;
        else if (c === 'b') ab += a;
        else if (c === 'c') abc += ab;
    }
    return abc;
}