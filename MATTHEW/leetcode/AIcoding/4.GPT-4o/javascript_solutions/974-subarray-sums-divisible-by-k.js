function subarraysDivByK(A, K) {
    const count = new Map();
    count.set(0, 1);
    let sum = 0, result = 0;

    for (let num of A) {
        sum += num;
        const mod = ((sum % K) + K) % K;
        result += count.get(mod) || 0;
        count.set(mod, (count.get(mod) || 0) + 1);
    }

    return result;
}