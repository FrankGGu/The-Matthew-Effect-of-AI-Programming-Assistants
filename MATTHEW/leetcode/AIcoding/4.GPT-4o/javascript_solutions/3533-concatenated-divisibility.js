function divisibleByConcatenation(n) {
    let s = n.toString();
    for (let i = 1; i <= s.length; i++) {
        let num = parseInt(s.slice(0, i));
        if (n % num !== 0) {
            return false;
        }
    }
    return true;
}