var countOfAtoms = function(formula) {
    const stack = [{}];
    let i = 0;
    const n = formula.length;

    while (i < n) {
        const char = formula[i];

        if (char === '(') {
            stack.push({});
            i++;
        } else if (char === ')') {
            i++;
            let numStr = '';
            while (i < n && '0' <= formula[i] && formula[i] <= '9') {
                numStr += formula[i];
                i++;
            }
            const num = parseInt(numStr || '1');
            const top = stack.pop();

            for (const atom in top) {
                if (top.hasOwnProperty(atom)) {
                    stack[stack.length - 1][atom] = (stack[stack.length - 1][atom] || 0) + top[atom] * num;
                }
            }
        } else {
            let atom = '';
            atom += char;
            i++;
            while (i < n && 'a' <= formula[i] && formula[i] <= 'z') {
                atom += formula[i];
                i++;
            }

            let numStr = '';
            while (i < n && '0' <= formula[i] && formula[i] <= '9') {
                numStr += formula[i];
                i++;
            }
            const num = parseInt(numStr || '1');
            stack[stack.length - 1][atom] = (stack[stack.length - 1][atom] || 0) + num;
        }
    }

    const result = stack[0];
    const atoms = Object.keys(result).sort();
    let ans = '';
    for (const atom of atoms) {
        ans += atom;
        if (result[atom] > 1) {
            ans += result[atom];
        }
    }
    return ans;
};