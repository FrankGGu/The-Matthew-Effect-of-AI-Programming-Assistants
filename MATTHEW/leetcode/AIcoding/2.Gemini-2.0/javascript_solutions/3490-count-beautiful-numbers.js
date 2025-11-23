var countBeautifulNumbers = function(n) {
    const primes = [2, 3, 5, 7];
    let count = 0;

    function backtrack(index, num) {
        if (index === n) {
            count++;
            return;
        }

        for (let i = 0; i < primes.length; i++) {
            if (num % primes[i] === 0) {
                backtrack(index + 1, num * primes[i]);
            }
        }
    }

    backtrack(1, 1);
    return count;
};