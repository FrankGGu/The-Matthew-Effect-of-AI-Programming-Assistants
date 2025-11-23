function repeatedNTimes(A) {
    const count = {};
    for (let num of A) {
        if (count[num]) {
            return num;
        }
        count[num] = 1;
    }
}