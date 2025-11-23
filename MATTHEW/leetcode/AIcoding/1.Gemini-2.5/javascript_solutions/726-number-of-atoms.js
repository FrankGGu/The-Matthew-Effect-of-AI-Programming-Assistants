var countOfAtoms = function(formula) {
    const n = formula.length;
    let i = 0;
    const stack = [new Map()];

    const parseNumber = () => {
        let start = i;
        while (i < n && /\d/.test(formula[i])) {
            i++;
        }
        if (i === start) {
            return 1;
        }
        return parseInt(formula.substring(start, i));
    };

    while (i < n) {
        if (formula[i] === '(') {
            stack.push(new Map());
            i++;
        } else if (formula[i] === ')') {
            i++;
            const multiplier = parseNumber();
            const currentMap = stack.pop();
            const prevMap = stack[stack.length - 1];

            for (const [atom, count] of currentMap.entries()) {
                prevMap.set(atom, (prevMap.get(atom) || 0) + count * multiplier);
            }
        } else {
            let start = i;
            i++;
            while (i < n && /[a-z]/.test(formula[i])) {
                i++;
            }
            const atomName = formula.substring(start, i);

            const count = parseNumber();

            const topMap = stack[stack.length - 1];
            topMap.set(atomName, (topMap.get(atomName) || 0) + count);
        }
    }

    const finalCounts = stack[0];
    const sortedAtoms = Array.from(finalCounts.keys()).sort();

    let result = '';
    for (const atom of sortedAtoms) {
        result += atom;
        const count = finalCounts.get(atom);
        if (count > 1) {
            result += count;
        }
    }

    return result;
};