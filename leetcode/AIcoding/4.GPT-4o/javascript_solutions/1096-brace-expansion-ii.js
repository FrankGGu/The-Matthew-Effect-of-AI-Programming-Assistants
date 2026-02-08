var braceExpansionII = function(expression) {
    const parse = (s) => {
        const stack = [];
        let curr = new Set(['']);
        let i = 0;

        while (i < s.length) {
            if (s[i] === '{') {
                let j = i + 1;
                let braces = '';
                while (s[j] !== '}') {
                    braces += s[j];
                    j++;
                }
                const options = braces.split(',');
                const next = new Set();
                for (const prefix of curr) {
                    for (const option of options) {
                        next.add(prefix + option);
                    }
                }
                curr = next;
                i = j + 1;
            } else {
                let j = i;
                while (j < s.length && s[j] !== '{') {
                    j++;
                }
                const str = s.slice(i, j);
                const next = new Set();
                for (const prefix of curr) {
                    next.add(prefix + str);
                }
                curr = next;
                i = j;
            }
        }

        return Array.from(curr).sort();
    };

    return parse(expression);
};