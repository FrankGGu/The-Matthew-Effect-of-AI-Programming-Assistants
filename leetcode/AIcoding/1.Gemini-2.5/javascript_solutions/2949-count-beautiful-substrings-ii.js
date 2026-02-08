const isVowel = (char) => {
    return char === 'a' || char === 'e' || char === 'i' || char === 'o' || char === 'u';
};

const gcd = (a, b) => {
    while (b) {
        [a, b] = [b, a % b];
    }
    return a;
};

const lcm = (a, b) => {
    if (a === 0 || b === 0) return 0;
    return Math.abs(a * b) / gcd(a, b);
};

const getL = (k) => {
    if (k === 1) return 1;

    let primeFactors = new Map();
    let tempK = k;
    let d = 2;

    while (d * d <= tempK) {
        if (tempK % d === 0) {
            let count = 0;
            while (tempK % d === 0) {
                count++;
                tempK /= d;
            }
            primeFactors.set(d, count);
        }
        d++;
    }
    if (tempK > 1) {
        primeFactors.set(tempK, (primeFactors.get(tempK) || 0) + 1);
    }

    let L = 1;
    for (const [p, a] of primeFactors.entries()) {
        const powerNeeded = Math.ceil(a / 2);
        L = lcm(L, Math.pow(p, powerNeeded));
    }
    return L;
};

class SparseFenwickTree {
    constructor(maxVal) {
        this.tree = new Map();
        this.maxVal = maxVal;
    }

    update(index, delta) {
        index = index + 1;
        while (index <= this.maxVal + 1) {
            this.tree.set(index, (this.tree.get(index) || 0) + delta);
            index += index & (-index);
        }
    }

    query(index) {
        index = index + 1;
        let sum = 0;
        while (index > 0) {
            sum += this.tree.get(index) || 0;
            index -= index & (-index);
        }
        return sum;
    }
}

var beautifulSubstrings = function(s, k) {
    const n = s.length;
    let ans = 0;

    const L = getL(k);

    let currentBalance = 0;
    let currentVowels = 0;

    let mainMap = new Map();

    const initialShiftedBalance = 0 + n;
    const initialVowelsRem = 0 % L;

    if (!mainMap.has(initialShiftedBalance)) {
        mainMap.set(initialShiftedBalance, new Map());
    }
    if (!mainMap.get(initialShiftedBalance).has(initialVowelsRem)) {
        mainMap.get(initialShiftedBalance).set(initialVowelsRem, new SparseFenwickTree(n));
    }
    mainMap.get(initialShiftedBalance).get(initialVowelsRem).update(0, 1);

    for (let j = 0; j < n; j++) {
        const char = s[j];
        const isV = isVowel(char);

        if (isV) {
            currentBalance++;
            currentVowels++;
        } else {
            currentBalance--;
        }

        const shiftedBalanceJ = currentBalance + n;
        const vowelsRemJ = currentVowels % L;

        if (mainMap.has(shiftedBalanceJ)) {
            const innerMap = mainMap.get(shiftedBalanceJ);
            if (innerMap.has(vowelsRemJ)) {
                const ft = innerMap.get(vowelsRemJ);
                ans += ft.query(currentVowels - 1);
            }
        }

        if (!mainMap.has(shiftedBalanceJ)) {
            mainMap.set(shiftedBalanceJ, new Map());
        }
        const innerMapForUpdate = mainMap.get(shiftedBalanceJ);
        if (!innerMapForUpdate.has(vowelsRemJ)) {
            innerMapForUpdate.set(vowelsRemJ, new SparseFenwickTree(n));
        }
        innerMapForUpdate.get(vowelsRemJ).update(currentVowels, 1);
    }

    return ans;
};