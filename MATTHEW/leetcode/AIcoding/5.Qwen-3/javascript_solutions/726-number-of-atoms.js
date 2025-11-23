var countOfAtoms = function(formula) {
    const stack = [];
    const map = new Map();
    let i = 0;

    const parseNumber = () => {
        let num = 0;
        while (i < formula.length && /\d/.test(formula[i])) {
            num = num * 10 + parseInt(formula[i]);
            i++;
        }
        return num || 1;
    };

    const parseAtom = () => {
        let atom = '';
        while (i < formula.length && formula[i] !== '(' && formula[i] !== ')' && !/\d/.test(formula[i])) {
            atom += formula[i];
            i++;
        }
        return atom;
    };

    while (i < formula.length) {
        if (formula[i] === '(') {
            stack.push(map);
            map = new Map();
            i++;
        } else if (formula[i] === ')') {
            i++;
            const num = parseNumber();
            const prevMap = stack.pop();
            const currentMap = map;
            for (const [atom, count] of currentMap.entries()) {
                prevMap.set(atom, (prevMap.get(atom) || 0) + count * num);
            }
            map = prevMap;
        } else {
            const atom = parseAtom();
            const num = parseNumber();
            map.set(atom, (map.get(atom) || 0) + num);
        }
    }

    const result = [];
    for (const [atom, count] of [...map.entries()].sort()) {
        result.push(atom);
        if (count > 1) {
            result.push(count.toString());
        }
    }

    return result.join('');
};