function createSortedArray(instructions) {
    const mod = 1000000007;
    const maxVal = Math.max(...instructions);
    const BIT = new Array(maxVal + 1).fill(0);

    function update(index, value) {
        while (index < BIT.length) {
            BIT[index] += value;
            index += index & -index;
        }
    }

    function query(index) {
        let res = 0;
        while (index > 0) {
            res += BIT[index];
            index -= index & -index;
        }
        return res;
    }

    let result = 0;
    for (let i = 0; i < instructions.length; i++) {
        const val = instructions[i];
        const less = query(val - 1);
        const greater = query(maxVal) - query(val);
        result = (result + Math.min(less, greater)) % mod;
        update(val, 1);
    }

    return result;
}