var countOfAtoms = function(formula) {
    const stack = [];
    const map = new Map();
    let i = 0;

    while (i < formula.length) {
        if (formula[i] === '(') {
            stack.push(map);
            map = new Map();
            i++;
        } else if (formula[i] === ')') {
            i++;
            let num = 0;
            while (i < formula.length && isDigit(formula[i])) {
                num = num * 10 + parseInt(formula[i]);
                i++;
            }
            num = num === 0 ? 1 : num;
            for (let [key, value] of map) {
                map.set(key, value + (value * num));
            }
            map = stack.pop();
            for (let [key, value] of map) {
                map.set(key, value + (value * num));
            }
        } else {
            let atom = '';
            atom += formula[i];
            i++;
            while (i < formula.length && formula[i] >= 'a' && formula[i] <= 'z') {
                atom += formula[i];
                i++;
            }
            let num = 0;
            while (i < formula.length && isDigit(formula[i])) {
                num = num * 10 + parseInt(formula[i]);
                i++;
            }
            num = num === 0 ? 1 : num;
            map.set(atom, (map.get(atom) || 0) + num);
        }
    }

    const result = [];
    for (const [key, value] of map) {
        result.push(key + (value > 1 ? value : ''));
    }
    result.sort();
    return result.join('');
};

function isDigit(char) {
    return char >= '0' && char <= '9';
}