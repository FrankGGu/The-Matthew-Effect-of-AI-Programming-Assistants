var countOfAtoms = function(formula) {
    let i = 0;
    const n = formula.length;

    const parseAtom = () => {
        const sb = [];
        sb.push(formula[i++]);
        while (i < n && formula[i] >= 'a' && formula[i] <= 'z') {
            sb.push(formula[i++]);
        }
        return sb.join('');
    };

    const parseNum = () => {
        if (i === n || isNaN(formula[i])) {
            return 1;
        }
        let num = 0;
        while (i < n && !isNaN(formula[i])) {
            num = num * 10 + parseInt(formula[i++], 10);
        }
        return num;
    };

    const stack = [{}];
    while (i < n) {
        const ch = formula[i];
        if (ch === '(') {
            i++;
            stack.push({});
        } else if (ch === ')') {
            i++;
            const num = parseNum();
            const pop = stack.pop();
            const top = stack[stack.length - 1];
            for (const [atom, count] of Object.entries(pop)) {
                top[atom] = (top[atom] || 0) + count * num;
            }
        } else {
            const atom = parseAtom();
            const num = parseNum();
            const top = stack[stack.length - 1];
            top[atom] = (top[atom] || 0) + num;
        }
    }

    const map = stack[0];
    const sortedAtoms = Object.keys(map).sort();
    const result = [];
    for (const atom of sortedAtoms) {
        result.push(atom);
        if (map[atom] > 1) {
            result.push(map[atom].toString());
        }
    }
    return result.join('');
};